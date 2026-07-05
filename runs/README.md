# Install Scripts

Numbered for execution order. All idempotent — safe to run repeatedly.

The `run` orchestrator discovers and executes these in sorted order. Use `./run <filter>` to run a subset.

| Script | What it installs | Idempotency |
|--------|-----------------|-------------|
| `00-paru` | Paru AUR helper | `command -v` check |
| `10-zsh` | zsh, oh-my-zsh, plugins, pkgfile | `paru --needed`; `$SHELL` check |
| `20-neovim` | neovim, lua51, luarocks | `paru --needed` |
| `30-tmux` | tmux, TPM | `paru --needed`; dir check for TPM |
| `40-ghostty` | ghostty | `paru --needed` |
| `50-rust` | rustup, stylua, claude-tmux | `command -v` check; `cargo install` skips current |
| `60-node` | nodejs, npm | `paru --needed` |
| `65-bun` | bun (via bun.sh installer) | `command -v` check |
| `70-go` | go (via webi) | `command -v` check |
| `80-python` | uv | `command -v` check; `uv self update` |
| `90-dev-tools` | fzf, ripgrep, btop, eza, lazygit, glow, jq, docker | `paru --needed`; `systemctl enable` is idempotent |
| `91-rclone` | rclone (stable), fuse3; enables OneDrive/iCloud/Obsidian `--user` mounts | `paru --needed`; mounts enabled only if the remote is configured |
| `95-hscroll-volume` | horizontal-scroll volume control | `command -v` / dir check |

Remotes hold credentials, so they are **not** in dotfiles. After the first
deploy, run `rclone config` to add the `onedrive`, `icloud`, and `obsidian`
remotes, then re-run `./run rclone` to enable any mounts that were skipped.

## Examples

```bash
# Run everything
../run

# Run only rust installer
../run rust

# Preview without executing
../run --dry
```
