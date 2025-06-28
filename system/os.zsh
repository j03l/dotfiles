#!/usr/bin/env zsh

# OS detection utilities for cross-platform support

export OS_TYPE="unknown"
export OS_FAMILY="unknown"
export DISTRO="unknown"
export PACKAGE_MANAGER="unknown"

# Detect OS type
case "$(uname -s)" in
    Darwin*)
        OS_TYPE="macos"
        OS_FAMILY="darwin"
        DISTRO="macos"
        PACKAGE_MANAGER="brew"
        ;;
    Linux*)
        OS_TYPE="linux"
        OS_FAMILY="linux"
        
        # Detect Linux distribution
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO="${ID:-unknown}"
            
            case "$DISTRO" in
                debian|ubuntu|pop|elementary|linuxmint)
                    PACKAGE_MANAGER="apt"
                    ;;
                fedora|rhel|centos|rocky|almalinux)
                    PACKAGE_MANAGER="dnf"
                    ;;
                arch|manjaro|endeavouros)
                    PACKAGE_MANAGER="pacman"
                    ;;
                opensuse*)
                    PACKAGE_MANAGER="zypper"
                    ;;
                *)
                    PACKAGE_MANAGER="unknown"
                    ;;
            esac
        fi
        ;;
    *)
        OS_TYPE="unknown"
        ;;
esac

# Helper functions
is_macos() {
    [ "$OS_TYPE" = "macos" ]
}

is_linux() {
    [ "$OS_TYPE" = "linux" ]
}

is_debian_based() {
    [ "$PACKAGE_MANAGER" = "apt" ]
}

is_fedora_based() {
    [ "$PACKAGE_MANAGER" = "dnf" ]
}

is_arch_based() {
    [ "$PACKAGE_MANAGER" = "pacman" ]
}

# Package manager abstraction
pkg_install() {
    case "$PACKAGE_MANAGER" in
        brew)
            brew install "$@"
            ;;
        apt)
            sudo apt install -y "$@"
            ;;
        dnf)
            sudo dnf install -y "$@"
            ;;
        pacman)
            sudo pacman -S --noconfirm "$@"
            ;;
        zypper)
            sudo zypper install -y "$@"
            ;;
        *)
            echo "Unknown package manager: $PACKAGE_MANAGER"
            return 1
            ;;
    esac
}

pkg_update() {
    case "$PACKAGE_MANAGER" in
        brew)
            brew update
            ;;
        apt)
            sudo apt update
            ;;
        dnf)
            sudo dnf check-update
            ;;
        pacman)
            sudo pacman -Sy
            ;;
        zypper)
            sudo zypper refresh
            ;;
        *)
            echo "Unknown package manager: $PACKAGE_MANAGER"
            return 1
            ;;
    esac
}

pkg_upgrade() {
    case "$PACKAGE_MANAGER" in
        brew)
            brew upgrade
            ;;
        apt)
            sudo apt upgrade -y
            ;;
        dnf)
            sudo dnf upgrade -y
            ;;
        pacman)
            sudo pacman -Su --noconfirm
            ;;
        zypper)
            sudo zypper update -y
            ;;
        *)
            echo "Unknown package manager: $PACKAGE_MANAGER"
            return 1
            ;;
    esac
}