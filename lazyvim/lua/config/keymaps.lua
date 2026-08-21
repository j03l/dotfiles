-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Go error-handling snippets, carried over from the previous config.
--
-- These lived on <leader>e there, which is LazyVim's file explorer: pressing
-- <leader>ee opened the explorer instead, because the single-key map resolves
-- before the two-key one can complete. They live under <leader>o here -- the
-- "o" of Go, since "g" belongs to git.
vim.keymap.set("n", "<leader>oe", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Go: if err return" })
vim.keymap.set("n", "<leader>oa", 'oassert.NoError(err, "")<Esc>F";a', { desc = "Go: assert no error" })
vim.keymap.set(
  "n",
  "<leader>of",
  'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj',
  { desc = "Go: if err log.Fatal" }
)
vim.keymap.set(
  "n",
  "<leader>ol",
  'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i',
  { desc = "Go: if err logger.Error" }
)

-- Replace the word under the cursor across the file.
vim.keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Make the current file executable.
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Paste over a selection without clobbering the register.
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
