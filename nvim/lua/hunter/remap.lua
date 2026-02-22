vim.keymap.set("n", "<leader>pv", function()
    require("hunter.floating_netrw").open()
end, { desc = "Open file explorer (float)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false, desc = "Plenary test file" })

-- better up/down (visual lines when no count)
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
vim.keymap.set("n", "=ap", "ma=ap'a", { desc = "Indent paragraph" })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end, { desc = "Start Vim With Me" })
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end, { desc = "Stop Vim With Me" })
vim.keymap.set("n", "<leader>lt", function()
    vim.cmd [[ PlenaryBustedFile % ]]
end, { desc = "Plenary busted test" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete to void" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape insert mode" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })
vim.keymap.set("n", "<leader>gg", "<cmd>silent !tmux neww lazygit<CR>", { desc = "Lazygit" })
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>", { desc = "Tmux sessionizer vsplit" })
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>", { desc = "Tmux sessionizer new window" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { desc = "Go: if err return" }
)

vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a",
    { desc = "Go: assert no error" }
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj",
    { desc = "Go: if err log.Fatal" }
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i",
    { desc = "Go: if err logger.Error" }
)

vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end, { desc = "Make it rain" })

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
vim.keymap.set("n", "<leader>K", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<CR>", { desc = "Switch to last buffer" })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
vim.keymap.set("x", "<", "<gv", { desc = "Indent left (stay selected)" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right (stay selected)" })

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })
vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>", { desc = "Save and quit all" })
vim.keymap.set("n", "<leader>q!", "<cmd>qa!<cr>", { desc = "Force quit all (discard changes)" })
