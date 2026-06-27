# Install Scripts

Numbered for execution order. All idempotent — safe to run repeatedly. Each sources `lib/platform.sh` and either branches per OS or self-skips on the platform it doesn't apply to.

The `run` orchestrator executes every **executable** file here in sorted order, so non-executable files (`macos.Brewfile`, this README) are skipped. Use `./run <filter>` to run a subset.

| Script | OS | What it installs |
|--------|----|------------------|
| `00-paru` | Linux | paru AUR helper |
| `01-brew` | macOS | Homebrew + everything in `macos.Brewfile` |
| `10-zsh` | both | zsh, plugins, oh-my-zsh (paru + system dirs / brew + curl installer); sets default shell |
| `20-neovim` | both | neovim, luarocks, tree-sitter |
| `30-tmux` | both | tmux + TPM |
| `40-terminals` | both | ghostty + kitty |
| `50-rust` | both | rustup, stylua, claude-tmux (brew rustup is keg-only — added to PATH) |
| `60-node` | both | node (paru nodejs/npm; brew node, or defers to existing nvm) |
| `65-bun` | both | bun (bun.sh installer) |
| `70-go` | both | go |
| `80-python` | both | uv |
| `90-dev-tools` | both | fzf, ripgrep, btop, eza, expect, lazygit, glow, jq; bws (paru / cargo); docker is Linux-only |
| `91-rclone` | Linux | rclone + FUSE for iCloud/OneDrive mounts |
| `95-hscroll-volume` | Linux | evdev horizontal-scroll-to-volume systemd service |
| `96-macos-defaults` | macOS | Finder/Dock/Safari/key-repeat defaults |
| `macos.Brewfile` | macOS | package list consumed by `01-brew` (not executable, not run directly) |

Package installs go through `pkg_install` (paru on Linux, `brew` on macOS) where formula names match; scripts branch explicitly where they differ.

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
