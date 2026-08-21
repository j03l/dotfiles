-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("HunterLazy", { clear = true })

-- Per-filetype right margin, carried over from the previous config.
-- "0" means no column at all for prose and Go (gofmt has no line limit).
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    local widths = {
      python = "88",
      rust = "100",
      java = "120",
      kotlin = "120",
      scala = "120",
      c = "100",
      cpp = "100",
      go = "0",
      javascript = "100",
      typescript = "100",
      typescriptreact = "100",
      javascriptreact = "100",
      html = "120",
      css = "120",
      ruby = "120",
      php = "120",
      lua = "100",
      zig = "100",
      markdown = "0",
      text = "0",
    }
    vim.opt_local.colorcolumn = widths[vim.bo.filetype] or "80"
  end,
})

-- Strip trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Transparent background, so the terminal's own opacity shows through.
-- Re-applied on every colorscheme change because most schemes reset these.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    for _, group in ipairs({
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "FoldColumn",
      "EndOfBuffer",
    }) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})
