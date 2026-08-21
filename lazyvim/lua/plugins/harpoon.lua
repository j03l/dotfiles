-- Pin the 3-4 files a task actually touches, then jump by number.
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end,
            { desc = "Harpoon add file" })
        vim.keymap.set("n", "<leader>H", function() harpoon:list():prepend() end,
            { desc = "Harpoon prepend file" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon menu" })

        for i = 1, 4 do
            vim.keymap.set("n", ("<M-%d>"):format(i), function()
                harpoon:list():select(i)
            end, { desc = ("Harpoon file %d"):format(i) })
        end
    end,
}
