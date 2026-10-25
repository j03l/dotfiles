#!/usr/bin/env bash
# Platform abstraction shared by deploy / install / secrets / runs.
# Source this, then use is_linux / is_macos / pkg_install / clip_copy_cmd.
#
#   source "$DOTFILES/lib/platform.sh"

case "$(uname -s)" in
    Linux)  PLATFORM=linux ;;
    Darwin) PLATFORM=macos ;;
    *)      PLATFORM=unknown ;;
esac
export PLATFORM

is_linux() { [[ "$PLATFORM" == linux ]]; }
is_macos() { [[ "$PLATFORM" == macos ]]; }

# Filesystem-safe machine identifier for per-machine config overrides
# (e.g. env/.config/zed/settings.<machine_id>.json).
machine_id() {
    if is_macos; then
        scutil --get LocalHostName
    else
        hostname -s
    fi
}

# Install packages with the native package manager.
# Diverging package *names* stay in explicit OS branches in the caller;
# this covers the common case where the name is identical.
pkg_install() {
    if is_macos; then
        brew install "$@"
    else
        paru -S --needed --noconfirm "$@"
    fi
}

# Name of the clipboard "copy" command for this platform (stdin -> clipboard).
clip_copy_cmd() {
    if is_macos; then
        echo pbcopy
    else
        echo wl-copy
    fi
}

# Read the BWS access token from the OS secret store (echoes to stdout).
# Linux goes through the Secret Service API, served by ksecretd on KDE or
# gnome-keyring on GNOME, so the lookup is identical on both. Not kwallet-query:
# kwalletd6 was retired in kwallet 6.28, and kwallet-query blocks ~50s on D-Bus
# activation before failing. The timeout guards headless logins. Keep this in
# sync with the equivalent block in env/.zsh_profile.
bws_token_from_store() {
    if is_macos; then
        security find-generic-password -s bws-access-token -w 2>/dev/null
    else
        timeout 5 secret-tool lookup server Passwords user bws-access-token 2>/dev/null
    fi
}

# Linux desktop pathway: kde | gnome. Persisted in ~/.dotfiles-desktop, the same
# way ~/.dotfiles-env persists home/work, so installers, deploy and the shell all
# agree on one answer. With no saved choice, guess from the running session and
# fall back to kde (the original setup). Empty on macOS.
DESKTOP_FILE="$HOME/.dotfiles-desktop"
DESKTOPS="kde gnome"

desktop_id() {
    is_linux || return 0
    local saved=""
    [[ -f "$DESKTOP_FILE" ]] && saved=$(<"$DESKTOP_FILE")
    if [[ " $DESKTOPS " == *" $saved "* ]]; then
        echo "$saved"
    elif [[ "${XDG_CURRENT_DESKTOP:-}" == *GNOME* ]]; then
        echo gnome
    else
        echo kde
    fi
}

# Interactive: confirm or pick the desktop pathway, then save it. Linux only.
choose_desktop() {
    is_linux || return 0
    local current="" answer d
    [[ -f "$DESKTOP_FILE" ]] && current=$(<"$DESKTOP_FILE")
    if [[ " $DESKTOPS " == *" $current "* ]]; then
        echo "Current desktop: $current"
        read -rp "Keep current? [Y/n] " answer
        [[ "${answer:-y}" =~ ^[Yy]$ ]] || current=""
    else
        current=""
    fi
    if [[ -z "$current" ]]; then
        echo "Select desktop (session: ${XDG_CURRENT_DESKTOP:-unknown}):"
        select d in $DESKTOPS; do
            if [[ -n "$d" ]]; then
                current="$d"
                break
            fi
        done
    fi
    echo "$current" > "$DESKTOP_FILE"
    echo "Desktop set to: $current"
}
