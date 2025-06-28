#!/usr/bin/env bash
#
# Git configuration setup

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Source OS detection utilities
source "$DOTFILES_ROOT/system/os.zsh"

# Create OS-specific gitconfig symlink
if is_macos; then
  # Use macOS version (with osxkeychain)
  if [ ! -L "$HOME/.gitconfig" ] || [ "$(readlink "$HOME/.gitconfig")" != "$DOTFILES_ROOT/git/gitconfig.symlink" ]; then
    ln -sf "$DOTFILES_ROOT/git/gitconfig.symlink" "$HOME/.gitconfig"
    echo "› Linked macOS gitconfig"
  fi
elif is_linux; then
  # Use Linux version (with cache credential helper)
  if [ ! -L "$HOME/.gitconfig" ] || [ "$(readlink "$HOME/.gitconfig")" != "$DOTFILES_ROOT/git/gitconfig-linux.symlink" ]; then
    ln -sf "$DOTFILES_ROOT/git/gitconfig-linux.symlink" "$HOME/.gitconfig"
    echo "› Linked Linux gitconfig"
  fi
fi

# Create gitignore if it doesn't exist
if [ ! -f "$DOTFILES_ROOT/git/gitignore.symlink" ]; then
  touch "$DOTFILES_ROOT/git/gitignore.symlink"
fi