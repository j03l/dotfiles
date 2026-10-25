# Scripts

Deployed to `~/.local/bin/`. Linux-only scripts (listed below) are skipped by `deploy` on macOS.

| Script | Description |
|--------|-------------|
| `tmux-sessionizer` | Fuzzy project finder + tmux session manager. Reads config from `~/.config/tmux-sessionizer/tmux-sessionizer.conf`. Supports session commands (`-s`), splits (`--vsplit`/`--hsplit`). |
| `tmux-bookmark` | Session bookmark manager: 4 slots (h/j/k/l) bound at runtime. Subcommands: `set`, `goto`, `status`. |
| `tmux-project` | Quick session switcher: `tmux-project <name> [path]` |
| `tmux-cht` | cht.sh cheat sheet browser via fzf. Uses language/command lists from `~/.config/tmux/`. |
| `tmux-claude` | Claude Code scratchpad popup helper (bound to `prefix a`). |
| `tmux-claude-resurrect-save` | tmux-resurrect post-save hook: records which Claude conversation (session UUID) each pane holds. |
| `tmux-claude-resurrect-restore` | tmux-resurrect post-restore hook: relaunches each pane's own conversation (`claude --resume <uuid>`, else `--continue`). |
| `tmux-status-resize` | Recomputes tmux status/window formats to fit the client width. |
| `cheatsheet` | Opens `~/dotfiles/KEYBINDS.md` with glow |
| `clip` | Cross-platform clipboard copy (pbcopy / wl-copy / xclip); used by tmux copy-mode |
| `extract` | Extract archives (tar.gz/bz2/xz/zst, zip, 7z, rar, …) / mount disk images (`.dmg` via hdiutil on macOS) |
| `git-up` | `git pull` with a short log of what changed (the script's `git-reup` rebase mode needs a `git-reup` symlink, which isn't deployed) |
| `git-promote` | Promote a local branch to a remote tracking branch of the same name |
| `git-nuke` | Delete a branch locally and on the origin remote (refuses to run without a branch name) |
| `git-delete-local-merged` | Delete local branches already merged into HEAD |

### Linux-only (not deployed on macOS)

`sudo` (askpass wrapper: ksshaskpass on KDE, `zenity-askpass` on GNOME), `zenity-askpass`, `hscroll-volume`, `kenesis`, `icloud-2fa-watch.sh`, `icloud-refresh-2fa.sh`, `onedrive-precache.sh`, `onedrive-bisync`, `onedrive-link-userdirs`.

- `onedrive-link-userdirs`: one-time move of `~/Desktop`, `~/Documents`, `~/Music`, `~/Pictures` and `~/Videos` into `~/OneDriveSync/`, leaving symlinks behind. `~/Downloads` stays local and is synced to timber by Syncthing instead. Remove any Syncthing shares of the moved folders first.
- `onedrive-bisync`: two-way sync of those folders between `~/OneDriveSync` and OneDrive (rclone bisync), run every 5 minutes by `rclone-onedrive-bisync.timer`. KDE `.directory`, `*.desktop` launchers, Windows `desktop.ini`/`Thumbs.db` and Syncthing markers are not synced, so each OS keeps its own. If bisync aborts asking for a resync, run `onedrive-bisync --resync`.

## Shell Aliases

```
ts   → tmux-sessionizer
tp   → tmux-project
tcht → tmux-cht
```
