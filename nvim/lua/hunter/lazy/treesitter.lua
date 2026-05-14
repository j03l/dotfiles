return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		init = function()
			local parsers = {
				"bash",
				"c",
				"css",
				"gitignore",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"python",
				"query",
				"rust",
				"templ",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			}

			local max_filesize = 500 * 1024

			local group = vim.api.nvim_create_augroup("HunterTreesitter", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
				group = group,
				callback = function()
					if vim.bo.buftype ~= "" then
						return
					end

					local fname = vim.api.nvim_buf_get_name(0)
					local ok, stats = pcall(vim.uv.fs_stat, fname)
					if ok and stats and stats.size > max_filesize then
						return
					end

					pcall(vim.treesitter.start, 0)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VeryLazy",
				once = true,
				callback = function()
					require("nvim-treesitter").install(parsers)
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}
