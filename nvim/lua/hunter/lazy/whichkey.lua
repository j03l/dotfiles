return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
        preset = "modern",

        -- Every keymap in this config carries a `desc`, so hiding the
        -- undescribed ones keeps the popup to things worth learning.
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,

        spec = {
            { "<leader>a", group = "ai / claude", icon = { icon = "󱚝", color = "purple" } },
            { "<leader>c", group = "tools",       icon = { icon = "󰅩", color = "blue" } },
            { "<leader>d", group = "debug",       icon = { icon = "", color = "red" } },
            { "<leader>e", group = "go errors",   icon = { icon = "󰟓", color = "cyan" } },
            { "<leader>g", group = "git",         icon = { icon = "", color = "orange" } },
            { "<leader>gh", group = "hunk",       icon = { icon = "", color = "green" } },
            { "<leader>p", group = "project / find", icon = { icon = "", color = "cyan" } },
            { "<leader>q", group = "quit",        icon = { icon = "󰗼", color = "red" } },
            { "<leader>t", group = "test / trouble", icon = { icon = "󰙨", color = "green" } },
            { "<leader>v", group = "lsp / view",  icon = { icon = "󰒍", color = "green" } },
            { "<leader>z", group = "zen / lsp",   icon = { icon = "󰚀", color = "purple" } },
        },
    },

    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer-local keymaps",
        },
    },
}
