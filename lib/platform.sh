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
bws_token_from_store() {
    if is_macos; then
        security find-generic-password -s bws-access-token -w 2>/dev/null
    else
        kwallet-query -f Passwords -r bws-access-token kdewallet 2>/dev/null
    fi
}
