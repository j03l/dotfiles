local themes = {
    ["tokyonight-night"] = {
        bar = "#16161e",
        accent = "#7aa2f7",
        dim = "#545c7e",
        sep = "#16161e",
    },
    ["rose-pine-moon"] = {
        bar = "#1f1d30",
        accent = "#c4a7e7",
        dim = "#6e6a86",
        sep = "#1f1d30",
    },
}

function ColorMyPencils(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)

    local t = themes[color] or themes["tokyonight-night"]

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = t.bar })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = t.bar, fg = t.accent })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = t.bar, fg = t.accent })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = t.bar, fg = t.dim })
    require("hunter.statusline").setup(color)

    -- Switch reactive.nvim preset for operator-pending highlights
    local ok, reactive = pcall(require, "reactive")
    if ok then
        if color == "rose-pine-moon" then
            vim.cmd("Reactive disable tokyonight")
            vim.cmd("Reactive enable rosepine")
        else
            vim.cmd("Reactive disable rosepine")
            vim.cmd("Reactive enable tokyonight")
        end
    end

    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = t.sep })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = t.bar })
    vim.api.nvim_set_hl(0, "@string.documentation", { link = "Comment" })
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
                on_highlights = function(hl, c)
                    -- Bold builtins (rose-pine style) with tokyonight color families
                    hl["@type.builtin"] = { fg = c.blue1, bold = true }
                    hl["@function.builtin"] = { fg = c.blue, bold = true }
                    hl["@constant.builtin"] = { fg = c.orange, bold = true }
                    hl["@variable.builtin"] = { fg = c.red, bold = true }
                    hl["@module.builtin"] = { fg = c.red, bold = true }

                    -- Bold statements (if/for/return pop more)
                    hl.Statement = { fg = c.magenta, bold = true }
                    hl.Directory = { fg = c.blue, bold = true }

                    hl["@string.documentation"] = { link = "Comment" }
                end,
            })

            ColorMyPencils()
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
        end
    },
}
