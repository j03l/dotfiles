return {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({ })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end, { desc = "Toggle Trouble" })

            vim.keymap.set("n", "[t", function()
                require("trouble").prev({ jump = true })
            end, { desc = "Prev Trouble item" })

            vim.keymap.set("n", "]t", function()
                require("trouble").next({ jump = true })
            end, { desc = "Next Trouble item" })

        end
}
