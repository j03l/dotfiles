return {
    "coder/claudecode.nvim",
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",  desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "Add buffer to Claude" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "Send to Claude" },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
    opts = {},
    config = function(_, opts)
        require("claudecode").setup(opts)

        -- Let C-h/j/k/l reach Claude's terminal instead of being eaten by
        -- vim-tmux-navigator while the terminal has focus.
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*claude*",
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                for _, k in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
                    vim.keymap.set("t", k, k, { buffer = buf, noremap = true })
                end
            end,
        })
    end,
}
