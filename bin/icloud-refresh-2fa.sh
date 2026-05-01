#!/usr/bin/env bash
# Refresh rclone iCloud trust token via KDE 2FA prompt.
# Idempotent: exits cleanly if token is still healthy.
set -euo pipefail

LOG="$HOME/.cache/rclone/icloud-2fa.log"
THROTTLE_FILE="$HOME/.cache/rclone/icloud-2fa-last-attempt"
THROTTLE_SECS=900
HEALTH_TIMEOUT=15

mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1
echo "=== $(date -Is) refresh attempt (pid $$) ==="

# Throttle — skip if a recent attempt happened
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

# Pre-prompt notification so the user knows what's coming
notify-send -a iCloud -i appointment-soon \
    "iCloud trust token expired" \
    "Get a 6-digit code from a trusted Apple device, then enter it in the dialog."

CODE=$(kdialog --title "iCloud 2FA" \
    --inputbox "Enter the 6-digit verification code from a trusted Apple device:" \
    "" 2>/dev/null) || {
    echo "User dismissed prompt"
    notify-send -a iCloud -i dialog-cancel \
        "iCloud refresh skipped" \
        "Try accessing ~/iCloud or wait until next login."
    exit 0
}

if [[ ! "$CODE" =~ ^[0-9]{6}$ ]]; then
    echo "Invalid code format: '$CODE'"
    notify-send -a iCloud -i dialog-error \
        "iCloud refresh failed" \
        "Code must be exactly 6 digits."
    exit 1
fi

# Pull obscured Apple ID password from rclone.conf, then decode it
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

if ! command -v expect >/dev/null; then
    echo "expect missing"
    notify-send -a iCloud -i dialog-error \
        "iCloud refresh failed" \
        "Install expect: sudo pacman -S expect"
    exit 1
fi

echo "Driving rclone config reconnect via expect"
expect <<EXPECT_SCRIPT
log_user 1
set timeout 60
spawn rclone config reconnect icloud:
expect {
    -re "(?i)password:" {
        send -- "$PASSWORD\r"
        exp_continue
    }
    -re "(?i)2fa|two.factor|verification|code" {
        send -- "$CODE\r"
        exp_continue
    }
    -re "Keep this .* remote" {
        send -- "y\r"
        exp_continue
    }
    -re "y/n>" {
        send -- "y\r"
        exp_continue
    }
    eof
}
EXPECT_SCRIPT
RECONNECT_RC=$?
echo "expect rc=$RECONNECT_RC"

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
