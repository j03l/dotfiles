# Neovim Config

Deploys to `~/.config/nvim/`. Plugins managed by [lazy.nvim](https://github.com/folke/lazy.nvim) — they auto-install on first launch.

## Structure

```
nvim/
├── init.lua                 # Entry point
├── lazy-lock.json           # Pinned plugin versions
├── after/queries/python/    # Custom treesitter highlights
└── lua/hunter/
    ├── init.lua             # Loads set, remap, lazy_init
    ├── set.lua              # Vim options
    ├── remap.lua            # Keybindings
    ├── lazy_init.lua        # Lazy.nvim bootstrap
    ├── statusline.lua       # Custom statusline
    └── lazy/                # Plugin specs
        ├── lsp.lua
        ├── treesitter.lua
        ├── telescope.lua
        ├── fugitive.lua
        ├── colors.lua
        └── ... (25 total)
```

## Key Plugins

| Plugin | Purpose |
|--------|---------|
| telescope | Fuzzy finder |
| treesitter | Syntax highlighting/parsing |
| lsp | Language server support |
| fugitive | Git integration |
| conform | Auto-formatting |
| dap | Debugging |
| navigator | Seamless tmux/nvim pane switching |
| undotree | Undo history visualization |
| trouble | Diagnostics list |

## Refresh

```bash
~/dotfiles/update-nvim
```
