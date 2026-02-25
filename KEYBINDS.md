Keybind Cheatsheet
══════════════════
All keybinds for our Prime-inspired setup.
Leader = Space

═══════════════════════════════════════════════════════════════════════════════
 NEOVIM
═══════════════════════════════════════════════════════════════════════════════

Navigation
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <leader>pv      │ Open file explorer (floating netrw)   │ remap.lua   │
│ j/k/↑/↓         │ Move by visual line (no count)        │ remap.lua   │
│ <C-d>           │ Half-page down (centered)             │ remap.lua   │
│ <C-u>           │ Half-page up (centered)               │ remap.lua   │
│ n               │ Next search result (centered)         │ remap.lua   │
│ N               │ Prev search result (centered)         │ remap.lua   │
│ <C-k>           │ Next quickfix item                    │ remap.lua   │
│ <C-j>           │ Prev quickfix item                    │ remap.lua   │
│ <leader>k       │ Next location list item               │ remap.lua   │
│ <leader>j       │ Prev location list item               │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Telescope (Fuzzy Finder)
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ <leader>pf      │ Find files                            │ telescope    │
│ <C-p>           │ Git files (tracked only)              │ telescope    │
│ <leader>ps      │ Grep with prompt                      │ telescope    │
│ <leader>pws     │ Grep word under cursor                │ telescope    │
│ <leader>pWs     │ Grep WORD under cursor                │ telescope    │
│ <leader>vh      │ Search help tags                      │ telescope    │
│ <leader>K       │ Search keymaps                        │ remap.lua    │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Harpoon (Quick File Switching)
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <leader>a       │ Add file to harpoon list              │ local.lua   │
│ <leader>A       │ Prepend file to harpoon list          │ local.lua   │
│ <C-e>           │ Toggle harpoon quick menu             │ local.lua   │
│ <M-1>           │ Jump to harpoon file 1                │ local.lua   │
│ <M-2>           │ Jump to harpoon file 2                │ local.lua   │
│ <M-3>           │ Jump to harpoon file 3                │ local.lua   │
│ <M-4>           │ Jump to harpoon file 4                │ local.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Editing
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ J (visual)      │ Move selected lines down              │ remap.lua   │
│ K (visual)      │ Move selected lines up                │ remap.lua   │
│ J (normal)      │ Join lines (cursor stays put)         │ remap.lua   │
│ <leader>p       │ Paste without losing register         │ remap.lua   │
│ <leader>d       │ Delete to void register               │ remap.lua   │
│ <leader>s       │ Search & replace word under cursor    │ remap.lua   │
│ <leader>x       │ chmod +x current file                 │ remap.lua   │
│ =ap             │ Format paragraph (cursor stays)       │ remap.lua   │
│ <C-s>           │ Save file (works in any mode)         │ remap.lua   │
│ < (visual)      │ Indent left (stay selected)           │ remap.lua   │
│ > (visual)      │ Indent right (stay selected)          │ remap.lua   │
│ gco             │ Add comment below current line        │ remap.lua   │
│ gcO             │ Add comment above current line        │ remap.lua   │
│ <leader>f       │ Format buffer (conform)               │ conform     │
│ <C-c>           │ Escape from insert mode               │ remap.lua   │
│ Q               │ Disabled (no Ex mode)                 │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Clipboard
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <leader>y       │ Yank to system clipboard              │ remap.lua   │
│ <leader>Y       │ Yank line to system clipboard         │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

LSP
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ gd              │ Go to definition                      │ init.lua    │
│ K               │ Hover documentation                   │ init.lua    │
│ <leader>vws     │ Workspace symbol search               │ init.lua    │
│ <leader>vd      │ Open diagnostic float                 │ init.lua    │
│ <leader>vca     │ Code action                           │ init.lua    │
│ <leader>vrr     │ References                            │ init.lua    │
│ <leader>vrn     │ Rename                                │ init.lua    │
│ [d              │ Prev diagnostic                       │ init.lua    │
│ ]d              │ Next diagnostic                       │ init.lua    │
│ <C-h>           │ Signature help (insert mode)          │ init.lua    │
│ <leader>zig     │ Restart LSP                           │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Completion (nvim-cmp)
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <C-p>           │ Select prev completion item           │ lsp.lua     │
│ <C-n>           │ Select next completion item           │ lsp.lua     │
│ <C-y>           │ Confirm selection                     │ lsp.lua     │
│ <C-Space>       │ Trigger completion                    │ lsp.lua     │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Snippets (LuaSnip)
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ <C-s>e          │ Expand snippet                        │ snippets     │
│ <C-s>;          │ Jump forward in snippet               │ snippets     │
│ <C-s>,          │ Jump backward in snippet              │ snippets     │
│ <C-E>           │ Change choice                         │ snippets     │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Git (Fugitive)
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ <leader>gs      │ Git status                            │ fugitive     │
│ <leader>p       │ Git push (in fugitive buffer)         │ fugitive     │
│ <leader>P       │ Git pull --rebase (in fugitive buf)   │ fugitive     │
│ <leader>t       │ Git push -u origin (set upstream)     │ fugitive     │
│ gu              │ Diffget ours                          │ fugitive     │
│ gh              │ Diffget theirs                        │ fugitive     │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Gitsigns
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ ]c              │ Next hunk                             │ gitsigns     │
│ [c              │ Previous hunk                         │ gitsigns     │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Trouble (Diagnostics)
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ <leader>tt      │ Toggle trouble                        │ trouble      │
│ [t              │ Prev trouble item                     │ trouble      │
│ ]t              │ Next trouble item                     │ trouble      │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Undotree / Zen Mode
┌─────────────────┬───────────────────────────────────────┬──────────────┐
│ <leader>u       │ Toggle undotree                       │ undotree     │
│ <leader>zz      │ Zen mode (with line numbers)          │ zenmode      │
│ <leader>zZ      │ Zen mode (no line numbers)            │ zenmode      │
└─────────────────┴───────────────────────────────────────┴──────────────┘

Go Error Handling
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <leader>ee      │ if err != nil { return err }          │ remap.lua   │
│ <leader>ea      │ assert.NoError(err, "")               │ remap.lua   │
│ <leader>ef      │ if err != nil { log.Fatalf(...) }     │ remap.lua   │
│ <leader>el      │ if err != nil { .logger.Error() }     │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Tools
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ <leader>cm      │ Open Mason                            │ remap.lua   │
│ <leader>K       │ Search keymaps (Telescope)            │ remap.lua   │
│ <leader>ca      │ Cellular automaton (make it rain)     │ remap.lua   │
│ <leader><leader>│ Switch to last buffer                 │ remap.lua   │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Theme Switching
┌─────────────────┬───────────────────────────────────────┬─────────────┐
│ :Tokyo          │ Switch to tokyonight-night            │ init.lua    │
│ :Rose           │ Switch to rose-pine-moon              │ init.lua    │
└─────────────────┴───────────────────────────────────────┴─────────────┘

Visual Indicators
┌────────────────────────────────┬──────────────────────────────────────┐
│ Mode-colored line numbers      │ Changes color per mode (reactive)    │
│ Operator-pending colors        │ d=red, y=yellow, c=cyan              │
│ Mode-colored -- INSERT --      │ Command line text changes per mode   │
│ Command line coloring          │ : commands shown in orange/gold      │
└────────────────────────────────┴──────────────────────────────────────┘

═══════════════════════════════════════════════════════════════════════════════
 TMUX (Ctrl-B prefix)
═══════════════════════════════════════════════════════════════════════════════

Press Ctrl-B Space for the interactive which-key menu.

Windows & Sessions
┌─────────────────────────────┬───────────────────────────────────────────┐
│ Ctrl-B then c               │ New window                                │
│ Ctrl-B then 1-9             │ Jump to window by number                  │
│ Ctrl-B then n               │ Next window                               │
│ Ctrl-B then p               │ Previous window                           │
│ Ctrl-B then b               │ Toggle last window                        │
│ Ctrl-B then s               │ List sessions (tree view)                 │
│ Ctrl-B then (               │ Previous session                          │
│ Ctrl-B then )               │ Next session                              │
│ Ctrl-B then d               │ Detach from tmux                          │
└─────────────────────────────┴───────────────────────────────────────────┘

Panes
┌─────────────────────────────┬───────────────────────────────────────────┐
│ Ctrl-B then |               │ Vertical split                            │
│ Ctrl-B then _               │ Horizontal split                          │
│ Ctrl+h/j/k/l               │ Move between panes AND nvim splits        │
│ Ctrl-B then h               │ Pane left                                 │
│ Ctrl-B then j               │ Pane down                                 │
│ Ctrl-B then k               │ Pane up                                   │
│ Ctrl-B then l               │ Pane right                                │
│ Ctrl-B then x               │ Kill pane                                 │
└─────────────────────────────┴───────────────────────────────────────────┘

Custom
┌─────────────────────────────┬───────────────────────────────────────────┐
│ Ctrl-B then Space           │ Which-key menu (all keybinds)             │
│ Ctrl-B then H               │ Cheatsheet popup                          │
│ Ctrl-B then a               │ Claude Code scratchpad popup              │
│ Ctrl-B then r               │ Reload tmux config                        │
│ Ctrl-B then D               │ Open TODO.md / study guide in nvim        │
│ Ctrl-B then S               │ Save sessions (tmux-resurrect)            │
│ Ctrl-B then R               │ Restore sessions (tmux-resurrect)         │
│ Ctrl-B then Ctrl-F          │ tmux-sessionizer (project switch)         │
└─────────────────────────────┴───────────────────────────────────────────┘

Session Bookmarks
4 slots (H/J/K/L) with colored status bar indicators. Click indicators to switch.
┌───────────────────────────────┬─────────────────────────────────────────┐
│ Ctrl-B then m then h          │ Set/toggle bookmark slot H (green)      │
│ Ctrl-B then m then j          │ Set/toggle bookmark slot J (purple)     │
│ Ctrl-B then m then k          │ Set/toggle bookmark slot K (cyan)       │
│ Ctrl-B then m then l          │ Set/toggle bookmark slot L (orange)     │
│ Ctrl-B then m then m          │ Clear all bookmarks (with confirm)      │
│ Ctrl-B then m then Esc        │ Cancel bookmark set mode                │
│ Alt-h                         │ Go to bookmark H                        │
│ Alt-j                         │ Go to bookmark J                        │
│ Alt-k                         │ Go to bookmark K                        │
│ Alt-l                         │ Go to bookmark L                        │
│ Click status bar indicator    │ Go to that bookmark                     │
└───────────────────────────────┴─────────────────────────────────────────┘

Copy Mode
┌─────────────────────────────┬───────────────────────────────────────────┐
│ Ctrl-B then [               │ Enter copy mode                           │
│ v in copy mode              │ Start selection                           │
│ y in copy mode              │ Yank to clipboard (wl-copy)               │
│ Ctrl-B then ?               │ tmux built-in key list                    │
└─────────────────────────────┴───────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════════════════════
 TMUX-SESSIONIZER (project switching)
═══════════════════════════════════════════════════════════════════════════════

Auto-restores saved sessions on first launch after reboot.
┌─────────────────┬──────────┬──────────────────────────────────────────┐
│ Ctrl-F          │ zsh      │ Open fzf project picker                  │
│ Ctrl-F          │ tmux     │ Open fzf project picker                  │
│ <C-f>           │ nvim     │ Open fzf project picker                  │
│ ts              │ zsh      │ Alias for tmux-sessionizer               │
└─────────────────┴──────────┴──────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════════════════════
 ANYWHERE
═══════════════════════════════════════════════════════════════════════════════
┌─────────────────┬────────────────────────────────────────────────────────┐
│ cheatsheet      │ Show this keybind reference (any terminal)             │
└─────────────────┴────────────────────────────────────────────────────────┘
