# Dotfiles

Modular, cross-platform dotfiles for **CachyOS/Arch Linux** and **macOS**, inspired by [ThePrimeagen's dev environment](https://github.com/ThePrimeagen/dev).

The OS is detected at runtime (`lib/platform.sh`); installers and configs branch per platform, so the same `./install` works on both. Linux uses paru/AUR + systemd + KDE Wallet; macOS uses Homebrew + macOS Keychain (and coexists with [Mackup](https://github.com/lra/mackup), which keeps syncing GUI app settings via iCloud — see [Mackup](#mackup-macos)).

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
├── run                  # Orchestrator: runs executable scripts in runs/ (sorted)
├── deploy               # Symlinks configs from repo to system
├── install              # Full setup: run + deploy + secrets
├── update-nvim          # Quick nvim-only refresh
├── update-dotfiles      # Config-only deploy (no packages)
├── lib/platform.sh      # OS detection + pkg_install/clip/machine_id helpers (sourced everywhere)
├── nvim/                # Neovim config → ~/.config/nvim/
├── env/                 # Configs mirroring the target filesystem
│   ├── .zshrc           # → ~/.zshrc (shared across both OSes)
│   ├── .zsh_profile     # → ~/.zsh_profile
│   ├── .mackup.cfg      # → ~/.mackup.cfg (macOS only)
│   ├── zsh/             # Per-OS fragments → ~/.config/zsh/os.zsh
│   │   ├── linux.zsh
│   │   └── macos.zsh
│   └── .config/         # ghostty, kitty, tmux, glow, zed, … (some with per-machine overrides, see below)
├── secrets              # Pulls secret files from Bitwarden Secrets Manager
├── secrets.env          # UUID → target path mapping (no actual secrets)
├── bin/                 # Scripts → ~/.local/bin/ (Linux-only ones skipped on macOS)
└── runs/                # Numbered, OS-aware install scripts
    ├── 00-paru          # (Linux) AUR helper
    ├── 01-brew          # (macOS) Homebrew + macos.Brewfile
    ├── 10-zsh  20-neovim  30-tmux  40-terminals
    ├── 50-rust  60-node  65-bun  70-go  80-python
    ├── 90-dev-tools
    ├── 91-rclone        # (Linux) iCloud/OneDrive mounts
    ├── 95-hscroll-volume# (Linux) evdev
    ├── 96-macos-defaults# (macOS) system defaults
    └── macos.Brewfile   # macOS package list (brew bundle)
```

## Platforms

| Concern | Linux (CachyOS/Arch) | macOS |
|---------|----------------------|-------|
| Packages | paru / AUR | Homebrew (`runs/macos.Brewfile`) |
| Secret store | KDE Wallet | macOS Keychain |
| Clipboard | `wl-copy` | `pbcopy` (via `bin/clip`) |
| Services | systemd user units | skipped |
| oh-my-zsh | `/usr/share/oh-my-zsh` | `~/.oh-my-zsh` |

OS-only installers self-skip on the other platform; `deploy` skips systemd units and Linux-only `bin/` scripts on macOS. Shell, git, ssh, nvim, tmux, ghostty/kitty configs are shared verbatim.

## Per-Machine Overrides

Some configs need values that differ per *machine*, not per OS (font family/size, window size, SSH connection lists, …) — `home`/`work` alone can't express this, since two machines in the same bucket can still want different values. Both mechanisms below key off `machine_id()` in `lib/platform.sh` (`scutil --get LocalHostName` on macOS, `hostname -s` on Linux). No override file for a machine → the shared defaults apply, nothing breaks.

- **kitty** — has a native `include`, so `deploy` just symlinks `env/.config/kitty/kitty.<machine_id>.conf` (tracked, one full file per machine) to `env/.config/kitty/local.conf` (gitignored), which `kitty.conf` `include`s last. A missing override file means kitty logs a one-line warning and skips the `include` — no crash.
- **zed** — Zed's `settings.json` has no `#include` mechanism, so `deploy` merges `env/.config/zed/settings.base.json` (shared, tracked) with an optional `env/.config/zed/settings.<machine_id>.json` (small, tracked, just the differing keys) via `jq`, writing the result to `~/.config/zed/settings.json` (generated, gitignored).

To add an override for a new machine: `source lib/platform.sh && machine_id` on that machine to get its key, then create `env/.config/kitty/kitty.<that-id>.conf` (full config) and/or `env/.config/zed/settings.<that-id>.json` (just the differing keys).

## Usage

All scripts support `--dry` for previewing actions. `run` executes every executable file in `runs/` in sorted order (non-executable files like `macos.Brewfile` are skipped).

```bash
# Deploy configs only (no package installs)
./update-dotfiles

# Refresh just neovim
./update-nvim

# Run a specific installer (grep filter)
./run brew
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

Secret config files (gitconfig, gh tokens, rclone, etc.) are stored in [Bitwarden Secrets Manager](https://bitwarden.com/help/secrets-manager-overview/) and pulled at setup time. The BWS access token is read from the OS secret store, so store it once per machine:

```bash
# Linux — KDE keyring (prompts for the value, hidden):
secret-tool store --label='Passwords/bws-access-token' server Passwords user bws-access-token

# macOS — Keychain (prompts for the value, hidden):
security add-generic-password -s bws-access-token -a "$USER" -w

# then, in a new shell (loads the token via .zsh_profile):
./secrets          # pull and write all secret files
./secrets --dry    # preview without writing
```

`install` runs secrets automatically when `BWS_ACCESS_TOKEN` is set. On macOS the `bws` CLI has no Homebrew formula — it's installed via Bitwarden's official installer script (handled by `runs/90-dev-tools`).

## Mackup (macOS)

On macOS, Mackup syncs app settings via iCloud. To stop it fighting `deploy` over the same files, `env/.mackup.cfg` (deployed to `~/.mackup.cfg`) lists the repo-owned apps under `[applications_to_ignore]` (`zsh`, `git`, `ssh`, `kitty`, `tmux`, `neovim` — the app's `.cfg` filename in Mackup's database, not its display name). Mackup keeps syncing everything else (bash, vim, btop, docker, `Library/*`, app prefs).

## What's Not Tracked

- Secret config files — managed by `./secrets` via Bitwarden Secrets Manager
- `~/.tmux/plugins/` — managed by TPM (`prefix + I`)
- Neovim plugins — managed by lazy.nvim (auto-installs on launch)
- `~/.config/kitty/local.conf` and `~/.config/zed/settings.json` — generated by `deploy` from the per-machine sources above
- SSH **private** keys — see [Commit signing](#commit-signing)

## Commit signing

Commits are SSH-signed with `~/.ssh/id_ed25519` (`user.signingkey` in `env/.gitconfig`).
`env/.ssh/allowed_signers` lists the trusted **public** keys so `git log --show-signature`
verifies locally; it is tracked, since public key material is not secret.

A key must also be registered on GitHub under *Settings → SSH and GPG keys* as a
**signing** key (separate from an authentication key) or GitHub marks the commits
"Unverified" regardless of what verifies locally:

```bash
gh auth refresh -h github.com -s admin:public_key,admin:ssh_signing_key
gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication --title "$(hostname -s)"
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing        --title "$(hostname -s)"
```

Private keys are **not** in Bitwarden yet, so a new machine needs its own key added
to GitHub and to `env/.ssh/allowed_signers`. See the commented SSH block in
`secrets.env` for the upload command if you'd rather sync them.

## Post-Install

- `exec zsh` to reload shell
- `prefix + r` to reload tmux config
- `prefix + I` to install tmux plugins (vim-tmux-navigator, tmux-which-key)
