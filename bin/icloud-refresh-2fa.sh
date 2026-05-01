#!/usr/bin/env bash
# Refresh rclone iCloud trust token via KDE 2FA prompt.
#
# Flow ordering matters: kdialog appears INSIDE the expect block, only
# after rclone has hit Apple's verify-trusteddevice endpoint and Apple
# has pushed a code to the trusted devices. That way the user sees the
# push notification before the dialog asks for the code.
set -euo pipefail

LOG="$HOME/.cache/rclone/icloud-2fa.log"
THROTTLE_FILE="$HOME/.cache/rclone/icloud-2fa-last-attempt"
THROTTLE_SECS=900
HEALTH_TIMEOUT=15

mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1
echo "=== $(date -Is) refresh attempt (pid $$) ==="

if [[ -f "$THROTTLE_FILE" ]]; then
    last=$(stat -c %Y "$THROTTLE_FILE")
    now=$(date +%s)
    age=$((now - last))
    if (( age < THROTTLE_SECS )); then
        echo "Throttled: last attempt ${age}s ago (< ${THROTTLE_SECS}s)"
        exit 0
    fi
fi

health_check() {
    timeout "$HEALTH_TIMEOUT" rclone lsd icloud: --max-depth 1 >/dev/null 2>&1
}

if health_check; then
    echo "Token healthy — nothing to do"
    exit 0
fi
echo "Token unhealthy — starting refresh flow"
touch "$THROTTLE_FILE"

if ! command -v expect >/dev/null; then
    echo "expect missing"
    notify-send -a iCloud -i dialog-error \
        "iCloud refresh failed" \
        "Install expect: sudo pacman -S expect"
    exit 1
fi

OBSCURED_PW=$(awk '
    /^\[icloud\]/ { in_section=1; next }
    /^\[/ { in_section=0 }
    in_section && /^password[[:space:]]*=/ {
        sub(/^password[[:space:]]*=[[:space:]]*/, "")
        print
        exit
    }
' ~/.config/rclone/rclone.conf)

if [[ -z "$OBSCURED_PW" ]]; then
    echo "Could not extract password from rclone.conf"
    notify-send -a iCloud -i dialog-error \
        "iCloud refresh failed" \
        "Password not found in rclone config."
    exit 1
fi
PASSWORD=$(rclone reveal "$OBSCURED_PW")

notify-send -a iCloud -i appointment-soon \
    "iCloud token expired" \
    "Contacting Apple — watch your trusted devices for a 6-digit code."

echo "Spawning rclone config reconnect"
export RCLONE_PASSWORD="$PASSWORD"
expect <<'EXPECT_SCRIPT'
log_user 1
set timeout 90
set password $::env(RCLONE_PASSWORD)

# Match only rclone's actual interactive prompt sentinels (`name>` lines).
# Loose regexes on words like "verification" or "two-factor" also match
# rclone's pre-prompt instruction text and cause exp_continue to fire
# multiple times per prompt cycle.

spawn rclone config reconnect icloud:

expect {
    -re "password>\\s*$" {
        send -- "$password\r"
        exp_continue
    }
    -re "config_2fa>\\s*$" {
        # rclone has hit Apple's verify endpoint; the push has gone out.
        if { [catch {
            set code [exec kdialog --title "iCloud 2FA" \
                --inputbox "A 6-digit verification code was sent to your trusted Apple devices.\n\nEnter the code below:" ""]
        } err] } {
            send_user "User dismissed dialog ($err)\n"
            exit 10
        }
        if { ![regexp {^[0-9]{6}$} $code] } {
            send_user "Invalid code format: $code\n"
            exit 11
        }
        send -- "$code\r"
        exp_continue
    }
    -re "y/n>\\s*$" {
        send -- "y\r"
        exp_continue
    }
    timeout {
        send_user "Timeout waiting for prompt\n"
        exit 12
    }
    eof
}
EXPECT_SCRIPT
RC=$?
unset RCLONE_PASSWORD
echo "expect rc=$RC"

case "$RC" in
    10)
        notify-send -a iCloud -i dialog-cancel \
            "iCloud refresh skipped" \
            "Try accessing ~/iCloud or wait until next login."
        exit 0
        ;;
    11)
        notify-send -a iCloud -i dialog-error \
            "iCloud refresh failed" \
            "Code must be exactly 6 digits."
        exit 1
        ;;
    12)
        notify-send -a iCloud -i dialog-error \
            "iCloud refresh failed" \
            "Timed out waiting for rclone. Check ~/.cache/rclone/icloud-2fa.log"
        exit 1
        ;;
esac

if health_check; then
    echo "Reconnect succeeded — restarting mount"
    notify-send -a iCloud -i emblem-success \
        "iCloud reconnected" \
        "Trust token refreshed (~30 days)."
    systemctl --user restart rclone-icloud.service
    rm -f "$THROTTLE_FILE"
    exit 0
fi

echo "Reconnect failed — token still unhealthy"
notify-send -a iCloud -i dialog-error \
    "iCloud reconnect failed" \
    "Check ~/.cache/rclone/icloud-2fa.log"
exit 1
