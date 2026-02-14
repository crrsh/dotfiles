return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		branch = "master", -- NOTE: eventually move to main branch
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"regex",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = false,
				ignore_install = {},

				indent = { enable = true },

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,

					-- Disable slow treesitter highlight for large files
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["ah"] = "@assignment.lhs", -- can these be moved to mini.ai ?
							["al"] = "@assignment.rhs",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]C"] = "@class.outer",
							["]a"] = "@parameter.outer",
							["]c"] = "@comment.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[C"] = "@class.outer",
							["[a"] = "@parameter.outer",
							["[c"] = "@comment.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							[">a"] = "@parameter.inner", -- TODO: maybe ]s instead? s for swap?
						},
						swap_previous = {
							["<a"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
	{ -- TSContext toggle|enable|disable
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1, -- don't know if I really want to limit it to 1 - 0 is default and infinite
			multiline_threshold = 20, -- 20 is default - if function definition itself is over twenty lines it will limit it to 20 with this
			mode = "cursor", -- this is default but i might like 'topline' better as it still shows the context of a node at the top if cursor is not inside, can see the function name of the one above you
		},
	},
}
