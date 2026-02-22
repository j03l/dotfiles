# Dotfiles

Modular dotfiles system for CachyOS/Arch Linux, inspired by [ThePrimeagen's dev environment](https://github.com/ThePrimeagen/dev).

## Quick Start

```bash
# Full setup (packages + configs)
./install

# Preview what would happen
./install --dry
```

## Structure

```
dotfiles/
├── run                  # Orchestrator: runs scripts in runs/
├── deploy               # Copies configs from repo to system
├── install              # Full setup: run + deploy
├── update-nvim          # Quick nvim-only refresh
├── update-dotfiles      # Config-only deploy (no packages)
├── nvim/                # Neovim config → ~/.config/nvim/
├── env/                 # Dotfiles mirroring target filesystem
│   ├── .zshrc           # → ~/.zshrc
│   ├── .zsh_profile     # → ~/.zsh_profile
│   └── .config/
│       ├── ghostty/     # → ~/.config/ghostty/
│       ├── tmux/        # → ~/.config/tmux/
│       └── tmux-sessionizer/
├── secrets              # Pulls secret files from Bitwarden Secrets Manager
├── secrets.env          # UUID → target path mapping (no actual secrets)
├── bin/                 # Scripts → ~/.local/bin/ (chmod +x)
└── runs/                # Numbered install scripts
    ├── 00-paru
    ├── 10-zsh
    ├── 20-neovim
    ├── 30-tmux
    ├── 40-ghostty
    ├── 50-rust
    ├── 60-node
    ├── 70-go
    ├── 80-python
    └── 90-dev-tools
```

## Usage

All scripts support `--dry` for previewing actions.

```bash
# Deploy configs only (no package installs)
./update-dotfiles

# Refresh just neovim
./update-nvim

# Run a specific installer (grep filter)
./run paru
./run rust

# Preview all installers
./run --dry
```

## Workflow

1. Edit configs in `~/dotfiles/`
2. Run `./deploy` (or `./update-nvim` for just nvim)
3. Commit and push

Never edit files in `~/.config/` directly — they get overwritten on deploy.

## Secrets

Secret config files (gitconfig, gh tokens, rclone, etc.) are stored in [Bitwarden Secrets Manager](https://bitwarden.com/help/secrets-manager-overview/) and pulled at setup time.

```bash
# First-time setup: store your BWS access token in KDE Wallet
echo -n 'your-token' | kwallet-query -f Passwords -w bws-access-token kdewallet

# Open a new shell, then:
./secrets          # pull and write all secret files
./secrets --dry    # preview without writing
```

`install` runs secrets automatically when `BWS_ACCESS_TOKEN` is set (via `.zsh_profile` + KDE Wallet).

## What's Not Tracked

- Secret config files — managed by `./secrets` via Bitwarden Secrets Manager
- `~/.tmux/plugins/` — managed by TPM (`prefix + I`)
- Neovim plugins — managed by lazy.nvim (auto-installs on launch)

## Post-Install

- `exec zsh` to reload shell
- `prefix + r` to reload tmux config
- `prefix + I` to install tmux plugins (vim-tmux-navigator, tmux-which-key)
