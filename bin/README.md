# Scripts

Deployed to `~/.local/bin/` with `chmod +x`.

| Script | Description |
|--------|-------------|
| `tmux-sessionizer` | Fuzzy project finder + tmux session manager. Reads config from `~/.config/tmux-sessionizer/tmux-sessionizer.conf`. Supports session commands (`-s`), splits (`--vsplit`/`--hsplit`). |
| `tmux-project` | Quick session switcher: `tmux-project <name> [path]` |
| `tmux-cht` | cht.sh cheat sheet browser via fzf. Uses language/command lists from `~/.config/tmux/`. |
| `cheatsheet` | Opens `~/dotfiles/KEYBINDS.md` with glow |

## Shell Aliases

```
ts   → tmux-sessionizer
tp   → tmux-project
tcht → tmux-cht
```
