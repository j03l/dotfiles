# Keybind Cheatsheet

All keybinds for our Prime-inspired setup.

Leader = Space

---

## Neovim

### Navigation
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `<leader>pv`  | Open file explorer (floating netrw) | remap.lua  |
| `j`/`k`/`↑`/`↓` | Move by visual line (no count)   | remap.lua  |
| `<C-d>`       | Half-page down (centered)           | remap.lua  |
| `<C-u>`       | Half-page up (centered)             | remap.lua  |
| `n`           | Next search result (centered)       | remap.lua  |
| `N`           | Prev search result (centered)       | remap.lua  |
| `<C-k>`       | Next quickfix item                  | remap.lua  |
| `<C-j>`       | Prev quickfix item                  | remap.lua  |
| `<leader>k`   | Next location list item             | remap.lua  |
| `<leader>j`   | Prev location list item             | remap.lua  |

### Telescope (Fuzzy Finder)
| Binding       | Action                              | Source         |
|---------------|-------------------------------------|----------------|
| `<leader>pf`  | Find files                          | telescope.lua  |
| `<C-p>`       | Git files (tracked only)            | telescope.lua  |
| `<leader>ps`  | Grep with prompt                    | telescope.lua  |
| `<leader>pws` | Grep word under cursor              | telescope.lua  |
| `<leader>pWs` | Grep WORD under cursor              | telescope.lua  |
| `<leader>vh`  | Search help tags                    | telescope.lua  |
| `<leader>K`   | Search keymaps                      | remap.lua      |

### Harpoon (Quick File Switching)
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `<leader>a`   | Add file to harpoon list            | local.lua  |
| `<leader>A`   | Prepend file to harpoon list        | local.lua  |
| `<C-e>`       | Toggle harpoon quick menu           | local.lua  |
| `<M-1>`       | Jump to harpoon file 1              | local.lua  |
| `<M-2>`       | Jump to harpoon file 2              | local.lua  |
| `<M-3>`       | Jump to harpoon file 3              | local.lua  |
| `<M-4>`       | Jump to harpoon file 4              | local.lua  |

### Editing
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `J` (visual)  | Move selected lines down            | remap.lua  |
| `K` (visual)  | Move selected lines up              | remap.lua  |
| `J` (normal)  | Join lines (cursor stays put)       | remap.lua  |
| `<leader>p`   | Paste without losing register       | remap.lua  |
| `<leader>d`   | Delete to void register             | remap.lua  |
| `<leader>s`   | Search & replace word under cursor  | remap.lua  |
| `<leader>x`   | chmod +x current file               | remap.lua  |
| `=ap`         | Format paragraph (cursor stays)     | remap.lua  |
| `<C-s>`       | Save file (works in any mode)       | remap.lua  |
| `<` (visual)  | Indent left (stay selected)         | remap.lua  |
| `>` (visual)  | Indent right (stay selected)        | remap.lua  |
| `gco`         | Add comment below current line      | remap.lua  |
| `gcO`         | Add comment above current line      | remap.lua  |
| `<leader>f`   | Format buffer (conform)             | conform.lua|
| `<C-c>`       | Escape from insert mode             | remap.lua  |
| `Q`           | Disabled (no Ex mode)               | remap.lua  |

### Clipboard
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `<leader>y`   | Yank to system clipboard            | remap.lua  |
| `<leader>Y`   | Yank line to system clipboard       | remap.lua  |

### LSP
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `gd`          | Go to definition                    | init.lua   |
| `K`           | Hover documentation                 | init.lua   |
| `<leader>vws` | Workspace symbol search             | init.lua   |
| `<leader>vd`  | Open diagnostic float               | init.lua   |
| `<leader>vca` | Code action                         | init.lua   |
| `<leader>vrr` | References                          | init.lua   |
| `<leader>vrn` | Rename                              | init.lua   |
| `[d`          | Prev diagnostic                     | init.lua   |
| `]d`          | Next diagnostic                     | init.lua   |
| `<C-h>`       | Signature help (insert mode)        | init.lua   |
| `<leader>zig` | Restart LSP                         | remap.lua  |

### Completion (nvim-cmp)
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `<C-p>`       | Select prev completion item         | lsp.lua    |
| `<C-n>`       | Select next completion item         | lsp.lua    |
| `<C-y>`       | Confirm selection                   | lsp.lua    |
| `<C-Space>`   | Trigger completion                  | lsp.lua    |

### Snippets (LuaSnip)
| Binding       | Action                              | Source       |
|---------------|-------------------------------------|--------------|
| `<C-s>e`      | Expand snippet                      | snippets.lua |
| `<C-s>;`      | Jump forward in snippet             | snippets.lua |
| `<C-s>,`      | Jump backward in snippet            | snippets.lua |
| `<C-E>`       | Change choice                       | snippets.lua |

### Git (Fugitive)
| Binding       | Action                              | Source        |
|---------------|-------------------------------------|---------------|
| `<leader>gs`  | Git status                          | fugitive.lua  |
| `<leader>p`   | Git push (in fugitive buffer)       | fugitive.lua  |
| `<leader>P`   | Git pull --rebase (in fugitive buf) | fugitive.lua  |
| `<leader>t`   | Git push -u origin (set upstream)   | fugitive.lua  |
| `gu`          | Diffget ours                        | fugitive.lua  |
| `gh`          | Diffget theirs                      | fugitive.lua  |

### Gitsigns (Inline Git Indicators)
| Binding       | Action                              | Source         |
|---------------|-------------------------------------|----------------|
| `]c`          | Next hunk                           | gitsigns.lua   |
| `[c`          | Previous hunk                       | gitsigns.lua   |

### Trouble (Diagnostics)
| Binding       | Action                              | Source       |
|---------------|-------------------------------------|--------------|
| `<leader>tt`  | Toggle trouble                      | trouble.lua  |
| `[t`          | Prev trouble item                   | trouble.lua  |
| `]t`          | Next trouble item                   | trouble.lua  |

### Undotree
| Binding       | Action                              | Source        |
|---------------|-------------------------------------|---------------|
| `<leader>u`   | Toggle undotree                     | undotree.lua  |

### Zen Mode
| Binding       | Action                              | Source       |
|---------------|-------------------------------------|--------------|
| `<leader>zz`  | Zen mode (with line numbers)        | zenmode.lua  |
| `<leader>zZ`  | Zen mode (no line numbers)          | zenmode.lua  |

### Go Error Handling Snippets
| Binding       | Action                              | Source     |
|---------------|-------------------------------------|------------|
| `<leader>ee`  | `if err != nil { return err }`      | remap.lua  |
| `<leader>ea`  | `assert.NoError(err, "")`           | remap.lua  |
| `<leader>ef`  | `if err != nil { log.Fatalf(...) }` | remap.lua  |
| `<leader>el`  | `if err != nil { .logger.Error() }` | remap.lua  |

### Tools
| Binding            | Action                            | Source     |
|--------------------|-----------------------------------|------------|
| `<leader>cm`       | Open Mason                        | remap.lua  |
| `<leader>K`        | Search keymaps (Telescope)        | remap.lua  |
| `<leader>ca`       | Cellular automaton (make it rain) | remap.lua  |
| `<leader><leader>` | Switch to last buffer              | remap.lua  |

### Theme Switching
| Command  | Action                              | Source    |
|----------|-------------------------------------|-----------|
| `:Tokyo` | Switch to tokyonight-night          | init.lua  |
| `:Rose`  | Switch to rose-pine-moon            | init.lua  |

### Visual Indicators
| Feature                    | Description                              |
|----------------------------|------------------------------------------|
| Mode-colored line numbers  | Line number changes color per mode (reactive.nvim) |
| Operator-pending colors    | `d`=red, `y`=yellow, `c`=cyan           |
| Mode-colored `-- INSERT --`| Command line text changes color per mode |
| Command line coloring      | `:` commands shown in orange/gold        |

---

## tmux (Ctrl-B prefix)

Press `Ctrl-B Space` for the interactive which-key menu.

### Windows & Sessions
| Binding                | Action                              |
|------------------------|-------------------------------------|
| `Ctrl-B` then `c`     | New window                          |
| `Ctrl-B` then `1-9`   | Jump to window by number            |
| `Ctrl-B` then `n`     | Next window                         |
| `Ctrl-B` then `p`     | Previous window                     |
| `Ctrl-B` then `b`     | Toggle last window                  |
| `Ctrl-B` then `s`     | List sessions (tree view)           |
| `Ctrl-B` then `(`     | Previous session                    |
| `Ctrl-B` then `)`     | Next session                        |
| `Ctrl-B` then `d`     | Detach from tmux                    |

### Panes
| Binding                | Action                              |
|------------------------|-------------------------------------|
| `Ctrl-B` then `|`     | Vertical split                      |
| `Ctrl-B` then `_`     | Horizontal split                    |
| `Ctrl+h/j/k/l`        | Move between panes AND nvim splits (vim-tmux-navigator) |
| `Ctrl-B` then `h`     | Pane left                           |
| `Ctrl-B` then `j`     | Pane down                           |
| `Ctrl-B` then `k`     | Pane up                             |
| `Ctrl-B` then `l`     | Pane right                          |
| `Ctrl-B` then `x`     | Kill pane                           |

### Custom
| Binding                   | Action                              |
|---------------------------|-------------------------------------|
| `Ctrl-B` then `Space`    | Which-key menu (all keybinds)       |
| `Ctrl-B` then `H`        | Cheatsheet popup                    |
| `Ctrl-B` then `a`        | Claude Code scratchpad popup        |
| `Ctrl-B` then `r`        | Reload tmux config                  |
| `Ctrl-B` then `D`        | Open TODO.md / study guide in nvim  |
| `Ctrl-B` then `S`        | Save sessions (tmux-resurrect)      |
| `Ctrl-B` then `R`        | Restore sessions (tmux-resurrect)   |
| `Ctrl-B` then `Ctrl-F`   | tmux-sessionizer (project switch)   |

### Session Bookmarks

4 slots (H/J/K/L) with colored status bar indicators. Click indicators to switch.

| Binding                       | Action                              |
|-------------------------------|-------------------------------------|
| `Ctrl-B` then `m` then `h`   | Set/toggle bookmark slot H (green)  |
| `Ctrl-B` then `m` then `j`   | Set/toggle bookmark slot J (purple) |
| `Ctrl-B` then `m` then `k`   | Set/toggle bookmark slot K (cyan)   |
| `Ctrl-B` then `m` then `l`   | Set/toggle bookmark slot L (orange) |
| `Ctrl-B` then `m` then `m`   | Clear all bookmarks (with confirm)  |
| `Ctrl-B` then `m` then `Esc` | Cancel bookmark set mode            |
| `Alt-h`                       | Go to bookmark H                    |
| `Alt-j`                       | Go to bookmark J                    |
| `Alt-k`                       | Go to bookmark K                    |
| `Alt-l`                       | Go to bookmark L                    |
| Click status bar indicator    | Go to that bookmark                 |

### Copy Mode
| Binding                | Action                              |
|------------------------|-------------------------------------|
| `Ctrl-B` then `[`     | Enter copy mode                     |
| `v` in copy mode       | Start selection                     |
| `y` in copy mode       | Yank to clipboard (wl-copy)         |
| `Ctrl-B` then `?`     | tmux built-in key list              |

---

## tmux-sessionizer (project switching)

Auto-restores saved sessions on first launch after reboot (if a resurrect save exists).

| Binding       | Where    | Action                              |
|---------------|----------|-------------------------------------|
| `Ctrl-F`      | zsh      | Open fzf project picker             |
| `Ctrl-F`      | tmux     | Open fzf project picker             |
| `<C-f>`       | nvim     | Open fzf project picker             |
| `ts`          | zsh      | Alias for tmux-sessionizer          |

---

## Anywhere

| Binding       | Action                                     |
|---------------|--------------------------------------------|
| `cheatsheet`  | Show this keybind reference (any terminal)  |
