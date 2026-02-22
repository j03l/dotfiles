return {
    "coder/claudecode.nvim",
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>",             desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",         desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",     desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",   desc = "Continue Claude" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",         desc = "Add buffer to Claude" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",          mode = "v", desc = "Send to Claude" },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",    desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",      desc = "Deny diff" },
    },
    opts = {},
    config = function(_, opts)
        require("claudecode").setup(opts)

        -- Passthrough C-h/j/k/l in Claude terminal buffers
        -- so vim-tmux-navigator doesn't intercept them
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*claude*",
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                vim.keymap.set("t", "<C-h>", "<C-h>", { buffer = buf, noremap = true })
                vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = buf, noremap = true })
                vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = buf, noremap = true })
                vim.keymap.set("t", "<C-l>", "<C-l>", { buffer = buf, noremap = true })
            end,
        })
    end,
}
