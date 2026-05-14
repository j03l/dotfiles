return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Navigation: works in diff mode too (defer with vim.schedule).
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						vim.schedule(gs.next_hunk)
					end
				end, "Next git hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						vim.schedule(gs.prev_hunk)
					end
				end, "Prev git hunk")

				-- Hunk actions
				map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>ghs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage selection")
				map("v", "<leader>ghr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset selection")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")

				-- Buffer-wide
				map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")

				-- Blame & diff
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>ghB", gs.toggle_current_line_blame, "Toggle line blame")
				map("n", "<leader>ghd", gs.diffthis, "Diff against index")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff against HEAD~")

				-- Text object: select the current hunk (e.g. `dih`, `vih`).
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
			end,
		})
	end,
}
