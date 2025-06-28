#!/usr/bin/env bash
#
# Debian package installation

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Source OS detection and common functions
source "$DOTFILES_ROOT/system/os.zsh"

# Only run on Debian-based systems
if ! is_debian_based; then
  echo "This script is for Debian-based systems only"
  exit 0
fi

echo "› Installing Debian packages..."

# Update package lists
sudo apt update

# Install packages from packages.txt
while IFS= read -r package || [ -n "$package" ]; do
  # Skip comments and empty lines
  [[ "$package" =~ ^#.*$ ]] && continue
  [[ -z "$package" ]] && continue

  # Check if package is already installed
  if dpkg -l | grep -q "^ii  $package "; then
    echo "  $package is already installed"
  else
    echo "  Installing $package..."
    sudo apt install -y "$package"
  fi
done < debian/packages.txt

# Install special packages

# Tailscale
if ! command -v tailscale &> /dev/null; then
  echo "› Installing Tailscale..."
  curl -fsSL https://tailscale.com/install.sh | sh
fi

# UV (Python package manager)
if ! command -v uv &> /dev/null; then
  echo "› Installing UV..."
  pipx install uv
fi

# Install nvm and Node.js LTS
if [ ! -d "$HOME/.nvm" ]; then
  echo "› Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  
  # Source nvm for current session
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  
  echo "› Installing Node.js LTS..."
  nvm install --lts
  nvm use --lts
  nvm alias default lts/*
fi

# Rust and cargo (for dust and other rust tools)
if ! command -v cargo &> /dev/null; then
  echo "› Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Dust (disk usage analyzer)
if ! command -v dust &> /dev/null; then
  echo "› Installing dust..."
  cargo install du-dust
fi

# Install Nerd Fonts
if [ ! -d "$HOME/.local/share/fonts/NerdFonts" ]; then
  echo "› Installing Nerd Fonts..."
  mkdir -p "$HOME/.local/share/fonts/NerdFonts"
  cd "$HOME/.local/share/fonts/NerdFonts"

  # Download CaskaydiaCove Nerd Font
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
  unzip CascadiaCode.zip
  rm CascadiaCode.zip

  # Update font cache
  fc-cache -fv
  cd "$DOTFILES_ROOT"
fi

# Docker and Docker Compose
if ! command -v docker &> /dev/null; then
  echo "› Installing Docker..."
  # Add Docker's official GPG key
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  
  # Add the repository to Apt sources
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  # Add user to docker group
  sudo usermod -aG docker $USER
  echo "  Note: You'll need to log out and back in for Docker group membership to take effect"
fi

# Create Desktop folder
if [ ! -d "$HOME/Desktop" ]; then
  echo "› Creating Desktop folder..."
  mkdir -p "$HOME/Desktop"
fi

echo "› Debian packages installation complete!"
