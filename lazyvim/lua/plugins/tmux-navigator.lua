-- Seamless <C-h/j/k/l> movement between nvim splits and tmux panes.
--
-- LazyVim maps those four keys to <C-w>h/j/k/l in its own keymaps, and
-- vim-tmux-navigator maps them again in its plugin/ file. Whichever loads
-- last silently wins — which is exactly the bug that sat unnoticed in the
-- other config for months. So disable the plugin's own mappings and bind
-- them explicitly here, where the intent is visible.
return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
        { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Go to left window/pane" },
        { "<C-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Go to lower window/pane" },
        { "<C-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Go to upper window/pane" },
        { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right window/pane" },
    },
}
