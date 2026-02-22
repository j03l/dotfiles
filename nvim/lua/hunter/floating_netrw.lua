local M = {}

function M.open()
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
        title = " Explorer ",
        title_pos = "center",
        footer = {
            { " enter ", "Special" }, { "open", "Comment" },
            { "  % ", "Special" }, { "new file", "Comment" },
            { "  d ", "Special" }, { "new dir", "Comment" },
            { "  R ", "Special" }, { "rename", "Comment" },
            { "  D ", "Special" }, { "delete", "Comment" },
            { "  q ", "Special" }, { "close ", "Comment" },
        },
        footer_pos = "center",
    })
    vim.cmd("Ex")
    vim.wo[win].sidescrolloff = 0
    vim.wo[win].wrap = true
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].colorcolumn = ""

    local augroup = vim.api.nvim_create_augroup("FloatingNetrw", { clear = true })

    local function close_float()
        pcall(vim.api.nvim_del_augroup_by_name, "FloatingNetrw")
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    local function add_q_mapping(bufnr)
        vim.keymap.set("n", "q", close_float, { buffer = bufnr, nowait = true })
    end
    add_q_mapping(vim.api.nvim_get_current_buf())

    -- Map q on netrw buffers from subdirectory navigation
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "netrw",
        callback = function(ev)
            if vim.api.nvim_win_is_valid(win) and vim.api.nvim_get_current_win() == win then
                add_q_mapping(ev.buf)
            end
        end,
    })

    -- When a file is selected (non-netrw buffer enters the float),
    -- close the float and open the file in the main window
    vim.api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        callback = function()
            vim.schedule(function()
                if not vim.api.nvim_win_is_valid(win) then
                    pcall(vim.api.nvim_del_augroup_by_name, "FloatingNetrw")
                    return
                end
                if vim.api.nvim_get_current_win() ~= win then return end
                if vim.bo.filetype == "netrw" then return end

                local file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                close_float()
                if file ~= "" then
                    vim.cmd("edit " .. vim.fn.fnameescape(file))
                end
            end)
        end,
    })
end

return M
