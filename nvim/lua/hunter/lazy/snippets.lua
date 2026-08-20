
return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })

            -- friendly-snippets ships VSCode-format snippets but loads none of
            -- them until this runs. Without it get_snippets() returns 0 for
            -- every filetype, which is what it did.
            require("luasnip.loaders.from_vscode").lazy_load()

            -- These were <C-s>e / <C-s>; / <C-s>, but remap.lua binds a bare
            -- <C-s> to :w, which fires before any prefixed sequence completes,
            -- so none of them were reachable. Unprefixed now.
            -- (Core's <Tab>/<S-Tab> only jump vim.snippet, not LuaSnip.)
            vim.keymap.set({"i", "s"}, "<C-l>", function()
                ls.expand_or_jump()
            end, { silent = true, desc = "Snippet expand / jump forward" })

            vim.keymap.set({"i", "s"}, "<C-b>", function()
                ls.jump(-1)
            end, { silent = true, desc = "Snippet jump back" })

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})
        end,
    }
}

