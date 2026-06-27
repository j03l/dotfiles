# Scripts

Deployed to `~/.local/bin/`. Linux-only scripts (listed below) are skipped by `deploy` on macOS.

| Script | Description |
|--------|-------------|
| `tmux-sessionizer` | Fuzzy project finder + tmux session manager. Reads config from `~/.config/tmux-sessionizer/tmux-sessionizer.conf`. Supports session commands (`-s`), splits (`--vsplit`/`--hsplit`). |
| `tmux-bookmark` | Session bookmark manager: 4 slots (h/j/k/l) bound at runtime. Subcommands: `set`, `goto`, `status`. |
| `tmux-project` | Quick session switcher: `tmux-project <name> [path]` |
| `tmux-cht` | cht.sh cheat sheet browser via fzf. Uses language/command lists from `~/.config/tmux/`. |
| `tmux-claude` | Claude Code scratchpad popup helper (bound to `prefix a`). |
| `tmux-status-resize` | Recomputes tmux status/window formats to fit the client width. |
| `cheatsheet` | Opens `~/dotfiles/KEYBINDS.md` with glow |
| `clip` | Cross-platform clipboard copy (pbcopy / wl-copy / xclip); used by tmux copy-mode |
| `extract` | Extract archives / mount disk images (`.dmg` via hdiutil on macOS) |
| `git-up` | `git pull` with a short diffstat + log of what changed |
| `git-promote` | Promote a local branch to a remote tracking branch of the same name |
| `git-nuke` | Delete a branch locally and on the origin remote |
| `git-delete-local-merged` | Delete local branches already merged into HEAD |

### Linux-only (not deployed on macOS)

`sudo` (KDE ksshaskpass wrapper), `hscroll-volume`, `kenesis`, `icloud-2fa-watch.sh`, `icloud-refresh-2fa.sh`, `onedrive-precache.sh`.

## Shell Aliases

```
ts   → tmux-sessionizer
tp   → tmux-project
tcht → tmux-cht
```
