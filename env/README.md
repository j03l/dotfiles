# Environment Configs

Mirrors the target filesystem structure. `deploy` copies each item to its corresponding location.

## Mapping

| Repo path | Target |
|-----------|--------|
| `.zshrc` | `~/.zshrc` |
| `.zsh_profile` | `~/.zsh_profile` |
| `.config/ghostty/` | `~/.config/ghostty/` |
| `.config/tmux/` | `~/.config/tmux/` |
| `.config/tmux-sessionizer/` | `~/.config/tmux-sessionizer/` |
| `.ssh/config` | `~/.ssh/config` |

## zsh

- Oh-My-Zsh with geoffgarside theme
- Plugins: zsh-syntax-highlighting, zsh-autosuggestions, zsh-history-substring-search
- `Ctrl-f` bound to tmux-sessionizer
- Aliases for eza, paru, docker, tmux shortcuts

## ghostty

- CaskaydiaCove Nerd Font, size 13
- TokyoNight Night theme, 95% opacity

## tmux

- TokyoNight Night status bar
- Vi copy mode (wl-copy for Wayland)
- TPM plugins: vim-tmux-navigator, tmux-which-key
- `prefix + C-f` for sessionizer, `prefix + H` for cheatsheet
- `tmux.conf` + `cht-languages` + `cht-commands` data files
