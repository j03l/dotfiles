# Prime-Inspired Setup -- Study Guide

Based on ThePrimeagen's repos, customized for our system:
- **nvim config**: github.com/ThePrimeagen/init.lua
- **system setup**: github.com/ThePrimeagen/dev
- **tmux-sessionizer**: github.com/ThePrimeagen/tmux-sessionizer

---

## What We Changed From Prime's Original

| Area | Prime's Original | Our Version |
|------|-----------------|-------------|
| Terminal | Ghostty + rose-pine-moon + black bg | Ghostty + TokyoNight Night + 0.8 opacity |
| Font | Not set (default) | CaskaydiaCove Nerd Font Mono 13pt |
| tmux prefix | `Ctrl-A` | `Ctrl-B` (default) |
| Harpoon | Local path `~/personal/harpoon` | GitHub `ThePrimeagen/harpoon` branch harpoon2 |
| 99 (AI plugin) | Loaded from `~/personal/99` | Commented out (using Claude Code instead) |
| Mason LSPs | lua_ls, rust_analyzer, gopls, vtsls, tailwindcss | + ruff, yamlls, jsonls, taplo, dockerls, docker_compose |
| Telescope | Pinned to tag 0.1.5 | branch master (compat with nvim 0.11) |
| Titlebar | Hidden (gtk-titlebar = false) | Visible (doesn't work on KDE) |
| nvim colorscheme | Per-filetype (rose-pine-moon / tokyonight-night) | `tokyonight-night` for all files |
| nvim module name | `theprimeagen` | `hunter` |
| tmux status bar | Plain `bg=#333333 fg=#5eacd3` | TokyoNight Night palette, PREFIX indicator, "window" + date/time |
| tmux mouse | Disabled | Enabled |
| tmux scrollback | Default (2000) | 10000 |
| tmux pane nav | Basic h/j/k/l | vim-tmux-navigator (seamless nvim/tmux) |
| Project root | `~/personal/` | `~/dev/` |
| Leader key | Set in remap.lua | Moved to init.lua (fixes `<20>` bug) |
| Trouble nav | v2 API (broken on v3) | Updated to v3 API |
| Diagnostic nav | `[d`/`]d` swapped (bug) | Fixed (correct vim convention) |
| `vim.loop` | Used in 2 files | Updated to `vim.uv` (nvim 0.11) |

---

## Project Layout

```
~/dev/                              # All projects live here (flat)
├── alokai-storefront
├── astroids
├── chatagent
├── datadog
├── django-datadog
├── fgmod
├── hunterportfolio
├── ksystemstats
├── kwin-tile-gaps
├── nude-detection
└── runelite-4k-ui
```

Prime keeps everything flat under one directory. No grouping by language.
tmux-sessionizer searches `~/dev/` one level deep to find projects.

---

## Live Config Locations

| Config | Path |
|--------|------|
| Neovim | `~/.config/nvim/` |
| Ghostty | `~/.config/ghostty/config` |
| tmux | `~/.config/tmux/tmux.conf` |
| tmux-sessionizer | `~/.local/bin/tmux-sessionizer` |
| sessionizer config | `~/.config/tmux-sessionizer/tmux-sessionizer.conf` |
| zsh keybinds | `~/.zsh_profile` |
| cheatsheet | `~/.local/bin/cheatsheet` |
| LazyVim backup | `~/.config/nvim.lazyvim-backup/` |

---

## How The Workflow Works

```
Ghostty (terminal)
  └── zsh starts
        └── you run: tmux
              └── Ctrl-F -> tmux-sessionizer (fzf project picker)
                    └── picks project dir -> creates/switches tmux session
                          └── you run: nvim
```

- No auto-start. Ghostty opens zsh, you start tmux manually.
- `Ctrl-F` runs tmux-sessionizer from anywhere (zsh, tmux, or nvim).
- fzf shows all projects in `~/dev/` plus any running `[TMUX]` sessions.
- Each project gets its own tmux session with its own working directory.
- tmux handles terminals/panes. nvim handles editing. They don't overlap.

---

## tmux-sessionizer Config

File: `~/.config/tmux-sessionizer/tmux-sessionizer.conf`

- `TS_SEARCH_PATHS` — directories to search for projects (currently `~/dev`)
- `TS_EXTRA_SEARCH_PATHS` — additional paths with optional depth (e.g., `~/.config:2`)
- `TS_MAX_DEPTH` — how deep to search (default: 1)
- `TS_SESSION_COMMANDS` — commands for `-s` slot keybinds (Alt-h/t/n/s)

Session commands open in tmux window index 69+ so they don't interfere with normal windows.

Projects can have a `.tmux-sessionizer` file that runs when a session is created (hydration).

---

## Mason LSP Servers (ensure_installed)

| Server | Language | Source |
|--------|----------|--------|
| `lua_ls` | Lua | Prime's |
| `rust_analyzer` | Rust | Prime's |
| `gopls` | Go | Prime's |
| `vtsls` | TypeScript/JavaScript | Prime's |
| `tailwindcss` | Tailwind CSS | Prime's |
| `ruff` | Python (lint + format) | Added |
| `yamlls` | YAML configs | Added |
| `jsonls` | JSON configs | Added |
| `taplo` | TOML configs | Added |
| `dockerls` | Dockerfiles | Added |
| `docker_compose_language_service` | docker-compose.yml | Added |

---

## Study Reference

```
study-prime/
├── STUDY-GUIDE.md                 # This file
├── KEYBINDS.md                    # Full keybind cheatsheet
├── nvim/                          # His nvim config (reference copy)
│   ├── init.lua
│   └── lua/theprimeagen/
│       ├── init.lua               # Autocommands + LSP keymaps
│       ├── set.lua                # Vim options
│       ├── remap.lua              # Keymaps
│       ├── lazy_init.lua          # lazy.nvim bootstrap
│       └── lazy/                  # One file per plugin
└── dev/                           # His system bootstrap (reference copy)
    ├── run                        # Master script
    ├── arch-new-install           # Fresh Arch install script
    ├── runs/                      # Individual install scripts
    └── env/                       # Dotfiles
```
