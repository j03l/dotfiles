local M = {}

local themes = {
    ["tokyonight-night"] = {
        normal  = "#7aa2f7",  -- blue
        insert  = "#9ece6a",  -- green
        visual  = "#bb9af7",  -- magenta
        replace = "#f7768e",  -- red
        command = "#ff9e64",  -- orange
        terminal= "#7dcfff",  -- cyan
    },
    ["rose-pine-moon"] = {
        normal  = "#c4a7e7",  -- iris
        insert  = "#9ccfd8",  -- foam
        visual  = "#ea9a97",  -- rose
        replace = "#eb6f92",  -- love
        command = "#f6c177",  -- gold
        terminal= "#3e8fb0",  -- pine
    },
}

local mode_to_hl = {
    n = "normal", no = "normal",
    i = "insert", ic = "insert",
    v = "visual", V = "visual", [""] = "visual",
    s = "visual", S = "visual",
    R = "replace", Rv = "replace",
    c = "command",
    t = "terminal",
}

local current_theme = nil

function M.setup(color)
    current_theme = themes[color] or themes["tokyonight-night"]

    -- Set initial ModeMsg color
    vim.api.nvim_set_hl(0, "ModeMsg", { fg = current_theme.normal, bold = true })

    -- Update ModeMsg color on mode change
    local group = vim.api.nvim_create_augroup("HunterModeMsg", { clear = true })
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = group,
        callback = function()
            local mode = vim.api.nvim_get_mode().mode
            local hl_key = mode_to_hl[mode] or "normal"
            local color_fg = current_theme[hl_key] or current_theme.normal
            vim.api.nvim_set_hl(0, "ModeMsg", { fg = color_fg, bold = true })
        end,
    })

    -- Color command line text when typing commands
    vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = group,
        callback = function()
            vim.api.nvim_set_hl(0, "MsgArea", { fg = current_theme.command })
            vim.cmd("redraw")
        end,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = group,
        callback = function()
            vim.api.nvim_set_hl(0, "MsgArea", {})
        end,
    })
end

return M
