#!/bin/sh
# I like claude code, it does good vibes
# Install Claude Code via npm

set -e

# Prompt for installation
if [ "$1" != "--auto" ]; then
  echo "Claude Code is not installed. Would you like to install it? (y/n)"
  read -r response
  case "$response" in
    [yY][eE][sS]|[yY])
      ;;
    *)
      echo "Installation cancelled."
      exit 1
      ;;
  esac
fi

# Check dependencies
if ! command -v npm >/dev/null 2>&1; then
  echo "Error: npm is required. Please install Node.js first"
  exit 1
fi

node_version=$(node --version 2>/dev/null | sed 's/v//' | cut -d. -f1)
if [ -z "$node_version" ] || [ "$node_version" -lt 18 ]; then
  echo "Error: Node.js 18+ required. Current: $(node --version 2>/dev/null || echo 'not installed')"
  exit 1
fi

# Install Claude Code
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# Create wrapper script
echo "Creating wrapper script..."
cat > "$HOME/.dotfiles/bin/claude" << 'EOF'
#!/usr/bin/env bash
# Check if claude is installed
if [ ! -f "/Users/$USER/.claude/local/node_modules/.bin/claude" ]; then
  echo "Claude Code not found. Installing..."
  "$HOME/.dotfiles/claude-code/install.sh" --auto
fi

exec "/Users/$USER/.claude/local/node_modules/.bin/claude" "$@"
EOF

chmod +x "$HOME/.dotfiles/bin/claude"
echo "✓ Claude Code installed"
