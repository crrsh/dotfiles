return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = "TSUpdate",
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"fish",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"go",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			require("nvim-treesitter").install(parsers)

			local filetypes = vim.iter(parsers)
				:map(function(parser)
					return vim.treesitter.language.get_filetypes(parser)
				end)
				:flatten()
				:totable()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function()
					vim.treesitter.start()

					-- treesitter based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
