-- Label the leader groups this config adds, so they read as words in the
-- which-key popup instead of bare letters.
--
-- opts is a function rather than a table because which-key's `spec` is a list:
-- assigning a table would overwrite LazyVim's own groups instead of adding to
-- them. list_extend appends.
return {
    "folke/which-key.nvim",
    opts = function(_, opts)
        opts.spec = opts.spec or {}
        vim.list_extend(opts.spec, {
            { "<leader>o", group = "go errors", icon = { icon = "󰟓", color = "cyan" } },
            { "<leader>a", group = "ai / claude", icon = { icon = "󱚝", color = "purple" } },
            { "<leader>h", desc = "Harpoon add file" },
            { "<leader>H", desc = "Harpoon prepend file" },
            { "<leader>U", desc = "Undotree" },
        })
        return opts
    end,
}
