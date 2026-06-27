# Environment Configs

Mirrors the target filesystem structure. `deploy` symlinks each item to its corresponding location, OS-aware: systemd units are linked on Linux only, and the right `zsh/<os>.zsh` is linked to `os.zsh`.

## Mapping

| Repo path | Target |
|-----------|--------|
| `.zshrc` | `~/.zshrc` (shared across both OSes) |
| `.zsh_profile` | `~/.zsh_profile` |
| `zsh/linux.zsh` \| `zsh/macos.zsh` | `~/.config/zsh/os.zsh` (per-OS) |
| `.gitconfig` | `~/.gitconfig` |
| `.config/ghostty/` | `~/.config/ghostty/` |
| `.config/kitty/` | `~/.config/kitty/` (+ per-machine `local.conf`) |
| `.config/tmux/` | `~/.config/tmux/` (+ legacy `~/.tmux.conf`) |
| `.config/glow/`, `.config/zed/` | `~/.config/…` |
| `.config/tmux-sessionizer/` | `~/.config/tmux-sessionizer/` |
| `.config/systemd/user/` | `~/.config/systemd/user/` (Linux only) |
| `.ssh/config` | `~/.ssh/config` |

## zsh

`.zshrc` is shared across both OSes. OS-specific bits live in `zsh/{linux,macos}.zsh`, symlinked to `~/.config/zsh/os.zsh` and sourced early — that fragment sets `$ZSH` (the oh-my-zsh path differs per OS), appends `$OS_PLUGINS`, and defines `os_post_omz()` for things that must load after oh-my-zsh.

- Oh-My-Zsh with geoffgarside theme
- Plugins: zsh-syntax-highlighting, zsh-autosuggestions, zsh-history-substring-search (sourced from `/usr/share` on Linux, the Homebrew prefix on macOS)
- `Ctrl-f` bound to tmux-sessionizer
- Shared aliases for eza, docker, tmux, and uv. Linux-only aliases (paru, pacman/cpupower/hyprctl, `open=xdg-open`) live in `zsh/linux.zsh`.

## ghostty

- CaskaydiaCove Nerd Font, size 13
- TokyoNight Night theme, 95% opacity

## tmux

- TokyoNight Night status bar
- Vi copy mode — yanks via `clip` (pbcopy on macOS, wl-copy on Wayland)
- TPM plugins: vim-tmux-navigator, tmux-which-key
- `prefix + C-f` for sessionizer, `prefix + H` for cheatsheet
- `tmux.conf` + `cht-languages` + `cht-commands` data files
