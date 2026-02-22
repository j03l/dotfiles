require("hunter.set")
require("hunter.remap")
require("hunter.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local HunterGroup = augroup('Hunter', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = HunterGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_user_command("Tokyo", function() ColorMyPencils("tokyonight-night") end, {})
vim.api.nvim_create_user_command("Rose", function() ColorMyPencils("rose-pine-moon") end, {})

autocmd('FileType', {
    group = HunterGroup,
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
    end
})

autocmd('LspAttach', {
    group = HunterGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_extend("force", opts, { desc = "Hover info" }))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_extend("force", opts, { desc = "Workspace symbol" }))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, vim.tbl_extend("force", opts, { desc = "Find references" }))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, vim.tbl_extend("force", opts, { desc = "Signature help" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
