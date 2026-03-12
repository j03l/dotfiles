return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()

			-- Install parsers
			require("nvim-treesitter").install({
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"jsdoc",
				"bash",
				"go",
				"python",
				"templ",
			})

			vim.treesitter.language.register("templ", "templ")

			-- Disable treesitter for large files
			vim.api.nvim_create_autocmd("BufReadPre", {
				callback = function(args)
					local max_filesize = 500 * 1024 -- 500 KB
					local ok, stats = pcall(vim.uv.fs_stat, args.file)
					if ok and stats and stats.size > max_filesize then
						vim.treesitter.stop(args.buf)
						vim.notify(
							"File larger than 500KB, treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
