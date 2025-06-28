# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a topical dotfiles repository based on Holman's dotfiles pattern. Configuration is organized into topic directories (git, zsh, homebrew, etc.) with special file naming conventions that control loading and symlinking behavior.

## File Naming Conventions

- `*.symlink` - Files symlinked to `$HOME` without the `.symlink` extension
- `*.zsh` - Loaded automatically into zsh environment  
- `path.zsh` - Loaded first to set up PATH
- `completion.zsh` - Loaded last for autocomplete setup
- `install.sh` - Executed during installation within topic directories

## Key Commands

### Initial Setup
```bash
# First time setup
script/bootstrap
```

### Package Management  
```bash
# Install/update all dependencies
script/install

# Full system update and maintenance
bin/dot
```

### Development
```bash
# Install new Homebrew packages
brew bundle --file=Brewfile

# Add new topic - create directory with appropriate files
mkdir newtopic/
echo 'export NEWTOOL_PATH=/usr/local/bin' > newtopic/path.zsh
```

## Architecture

### Core Scripts
- **`script/bootstrap`** - Main installer that handles git setup and symlinks all `*.symlink` files
- **`script/install`** - Runs `brew bundle` and executes all topic `install.sh` scripts  
- **`bin/dot`** - Maintenance script for updates, macOS defaults, and full reinstallation

### Topic Organization
Each directory represents a configuration area:
- **bin/** - Command-line utilities (added to PATH)
- **git/** - Git configuration with aliases and custom commands
- **homebrew/** - Homebrew setup and PATH configuration
- **macos/** - System defaults and hostname setup
- **system/** - Shell aliases, environment variables, key bindings
- **zsh/** - Main shell configuration and loading logic

### Shell Loading Order
1. `*/path.zsh` files (PATH setup)
2. All other `*.zsh` files  
3. `*/completion.zsh` files (autocomplete)

### Private Configuration
- `~/.localrc` - Private environment variables (gitignored)
- `git/gitconfig.local.symlink` - Personal git config (gitignored)

## Package Management

The repository uses Homebrew managed via `Brewfile` with recent additions including:
- tailscale, postgresql@17, python@3.14, uv (Python package manager)
- Various development tools and GUI applications

## Notes

- Ruby topic was recently removed - no rbenv/ruby configuration present
- New `claude` binary added to bin/ directory
- Bootstrap handles file conflicts with user prompts (skip/overwrite/backup)
- Run `script/bootstrap` if missing `git/gitconfig.local.symlink`