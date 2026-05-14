# Keybind Cheatsheet

Prime-inspired setup. Leader = `Space`.

---

# Neovim

## Files & search (Telescope)

| Key | Action |
|---|---|
| `<leader>pf` | Find files |
| `<C-p>` | Git files |
| `<leader>ps` | Grep with prompt |
| `<leader>pws` | Grep word under cursor |
| `<leader>pWs` | Grep WORD under cursor |
| `<leader>vh` | Help tags |
| `<leader>K` | Search keymaps |
| `<leader>pv` | Open netrw |
| `<leader><leader>` | Last buffer |

## LSP (buffer-local when attached)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover info |
| `<C-h>` (insert) | Signature help |
| `<leader>vca` | Code action |
| `<leader>vrr` | References |
| `<leader>vrn` | Rename |
| `<leader>vws` | Workspace symbol |
| `<leader>vd` | Diagnostic float |
| `[d` / `]d` | Prev / next diagnostic |
| `<leader>zig` | Restart LSP |
| `<leader>cm` | Open Mason |
| `<leader>f` | Format buffer (conform) |

## Git

| Key | Action |
|---|---|
| `<leader>gs` | Git status (fugitive) |
| `<leader>gg` | Lazygit in new tmux window |
| `gu` / `gh` | Diffget ours / theirs |
| `<leader>p` | Push (in fugitive index) |
| `<leader>P` | Pull --rebase (in fugitive index) |

### Hunks (gitsigns)

| Key | Action |
|---|---|
| `]c` / `[c` | Next / prev hunk |
| `<leader>ghs` | Stage hunk (or selection in visual) |
| `<leader>ghr` | Reset hunk (or selection in visual) |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghS` / `<leader>ghR` | Stage / reset whole buffer |
| `<leader>ghb` | Blame line (full) |
| `<leader>ghB` | Toggle inline line-blame |
| `<leader>ghd` / `<leader>ghD` | Diff vs index / HEAD~ |
| `ih` (text object) | Select current hunk (`dih`, `vih`) |

## Tests & debugging

| Key | Action |
|---|---|
| `<leader>tr` | Run nearest test |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Run whole suite |
| `<leader>ta` | Run all tests in cwd |
| `<leader>tv` | Toggle test summary |
| `<leader>to` | Open test output |
| `<leader>tf` | Plenary test file |
| `<leader>tt` | Toggle Trouble |
| `[t` / `]t` | Prev / next Trouble item |
| `<F8>` | DAP continue |
| `<F10>` / `<F11>` / `<F12>` | Step over / into / out |
| `<leader>b` / `<leader>B` | Toggle / conditional breakpoint |
| `<leader>dr` | Toggle DAP repl |
| `<leader>ds` / `<leader>dS` | Toggle stacks / scopes |
| `<leader>dw` / `<leader>db` | Toggle watches / breakpoints |
| `<leader>dc` | Toggle console |

## Claude Code

| Key | Action |
|---|---|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` / `<leader>aC` | Resume / Continue |
| `<leader>ab` | Add buffer to Claude |
| `<leader>as` (visual) | Send selection |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |

## Harpoon

| Key | Action |
|---|---|
| `<leader>h` / `<leader>H` | Add / prepend file |
| `<C-e>` | Toggle quick menu |
| `<M-1>`…`<M-4>` | Jump to slot 1–4 |

## Editing

| Key | Action |
|---|---|
| `<C-s>` | Save (any mode) |
| `<leader>qq` / `<leader>q!` | Save+quit all / force quit |
| `<leader>y` / `<leader>Y` | Yank to clipboard / line |
| `<leader>p` (visual) | Paste without overwriting register |
| `<leader>d` | Delete to void |
| `<leader>s` | Find/replace word under cursor |
| `<leader>x` | `chmod +x %` |
| `J` (normal) | Join lines, cursor stays |
| `J` / `K` (visual) | Move selection down / up |
| `<` / `>` (visual) | Indent left/right (stay selected) |
| `=ap` | Indent paragraph |
| `<C-d>` / `<C-u>` | Half-page down/up (centered) |
| `n` / `N` | Search next/prev (centered) |
| `<C-k>` / `<C-j>` | Next / prev quickfix |
| `<leader>k` / `<leader>j` | Next / prev loclist |
| `gco` / `gcO` | Comment line below / above |
| `<C-c>` (insert) | Esc |
| `Q` | Disabled (was Ex mode) |

## Go snippets

| Key | Inserts |
|---|---|
| `<leader>ee` | `if err != nil { return err }` |
| `<leader>ef` | `if err != nil { log.Fatalf(...) }` |
| `<leader>el` | `if err != nil { logger.Error(...) }` |
| `<leader>ea` | `assert.NoError(err, "")` |

## Completion (nvim-cmp)

| Key | Action |
|---|---|
| `<C-n>` / `<C-p>` | Next / prev item |
| `<C-y>` | Confirm |
| `<C-Space>` | Trigger completion |

## Snippets (LuaSnip)

| Key | Action |
|---|---|
| `<C-s>e` | Expand at cursor |
| `<C-s>;` / `<C-s>,` | Jump next / prev |
| `<C-E>` | Cycle choice node |

## UI / windows

| Key | Action |
|---|---|
| `<C-f>` | tmux-sessionizer in new window |
| `<C-h/j/k/l>` | vim-tmux-navigator (pane ↔ tmux) |
| `<leader>u` | Toggle Undotree |
| `<leader>zz` / `<leader>zZ` | Zen mode / fancier Zen |
| `<leader>ca` | Make it rain (cellular automaton) |
| `<leader>lt` | Lazy plugin manager |

## User commands

| Command | Action |
|---|---|
| `:Tokyo` | Tokyonight Night colorscheme |
| `:Rose` | Rose-pine Moon colorscheme |
| `:Mason` | Mason package UI |
| `:Lazy` | Lazy plugin UI |
| `:Trouble` | Diagnostics list |

---

# Tmux (prefix `Ctrl-B`)

## Windows & sessions

| Key | Action |
|---|---|
| `prefix c` | New window |
| `prefix 1-9` | Jump to window |
| `prefix n` / `p` | Next / prev window |
| `prefix b` | Last window |
| `prefix s` | List sessions |
| `prefix (` / `)` | Prev / next session |
| `prefix d` | Detach |

## Panes

| Key | Action |
|---|---|
| `prefix |` / `_` | Vertical / horizontal split |
| `Ctrl-h/j/k/l` | Move between panes + nvim splits |
| `prefix h/j/k/l` | Move within tmux only |
| `prefix x` | Kill pane |
| `prefix Arrow` | Resize pane (repeatable) |

## Custom bindings

| Key | Action |
|---|---|
| `prefix Space` | Which-key menu |
| `prefix H` | Cheatsheet popup |
| `prefix a` | Claude Code scratchpad popup |
| `prefix r` | Reload tmux config |
| `prefix D` | Open TODO.md / study guide |
| `prefix S` / `R` | Save / restore sessions (resurrect) |
| `prefix Ctrl-F` | tmux-sessionizer |

## Session bookmarks

Four slots (H/J/K/L) shown in the status bar; click an indicator to jump.

| Key | Action |
|---|---|
| `prefix m h/j/k/l` | Set / toggle slot |
| `prefix m m` | Clear all (with confirm) |
| `prefix m Esc` | Cancel set mode |
| `Alt-h/j/k/l` | Go to slot H/J/K/L (no prefix) |

## Copy mode

| Key | Action |
|---|---|
| `prefix [` | Enter copy mode |
| `v` | Start selection |
| `y` | Yank to clipboard (wl-copy) |
| `prefix ?` | Built-in key list |

---

# tmux-sessionizer

Auto-restores saved sessions on first launch after reboot.

| Key | Context | Action |
|---|---|---|
| `Ctrl-F` | zsh / tmux | fzf project picker |
| `<C-f>` | nvim | fzf project picker |
| `ts` | zsh alias | Same |

---

# Anywhere

| Command | Action |
|---|---|
| `cheatsheet` | Show this reference (any terminal) |
