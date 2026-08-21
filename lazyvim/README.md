# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

---

## This copy

Second Neovim config, deployed to `~/.config/lazyvim` and reached with
`NVIM_APPNAME=lazyvim` (aliased to `lzv` in `.zshrc`). It shares nothing with
`~/dotfiles/nvim` — separate plugin dir, separate lockfile, separate state — so
either can break without touching the other.

### Ported from the other config

| File | What |
|------|------|
| `lua/plugins/tmux-navigator.lua` | `<C-h/j/k/l>` across nvim splits *and* tmux panes |
| `lua/plugins/harpoon.lua` | `<leader>h` pin, `<C-e>` menu, `<M-1>`–`<M-4>` jump |
| `lua/plugins/claudecode.lua` | `<leader>a*` Claude Code |
| `lua/plugins/cloak.lua` | masks secrets in `.env*` |
| `lua/plugins/undotree.lua` | `<leader>U` (not `<leader>u`, LazyVim's UI group) |
| `lua/config/keymaps.lua` | Go error snippets on `<leader>o*`, plus `<leader>rw` / `<leader>cx` |
| `lua/config/options.lua` | 4-space indents, no swapfile, persistent undo, `splitright`/`splitbelow` |
| `lua/config/autocmds.lua` | per-filetype `colorcolumn`, strip trailing whitespace, transparent bg |

### Two collisions worth remembering

`vim-tmux-navigator` and LazyVim both map `<C-h/j/k/l>`, and whichever loads
last wins silently. `tmux_navigator_no_mappings = 1` is set and the keys are
bound explicitly in the spec so the intent is visible.

The Go snippets were on `<leader>e*` in the other config. `<leader>e` is
LazyVim's file explorer, and a single-key map resolves before a two-key one can
complete — so `<leader>ee` opened the explorer and the snippet was unreachable.
They are on `<leader>o*` here.
