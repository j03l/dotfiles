-- <leader>u is LazyVim's UI-toggle group, so undotree takes <leader>U here.
return {
    "mbbill/undotree",
    keys = {
        { "<leader>U", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
    },
}
