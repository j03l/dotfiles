-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Carried over from the previous config.
vim.opt.guicursor = "n-v-c-i-o:block,r-cr:hor20"
vim.opt.cursorlineopt = "number"
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- 4-space indents; LazyVim defaults to 2.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- No swapfiles, no backups, but keep undo history across sessions.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.title = true
vim.opt.titlestring = "lazyvim:%t"

-- New splits open right and below, matching every other editor.
-- (The previous config left both false, so :vsplit opened to the LEFT.)
vim.opt.splitright = true
vim.opt.splitbelow = true
