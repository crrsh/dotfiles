return {
	{
		"nvim-mini/mini.icons",
		version = false,
		lazy = true,
		opts = {},
	},
	{
		"nvim-mini/mini.files",
		version = false,
		dependencies = { "nvim-mini/mini.icons" },
		keys = {
			{
				"-",
				function()
					if not MiniFiles.close() then
						local path = vim.api.nvim_buf_get_name(0)
						if vim.fn.filereadable(path) == 0 then
							path = vim.fn.fnamemodify(path, ":h")
						end
						MiniFiles.open(path, false)
					end
				end,
				desc = "Toggle mini.files (target buf dir)",
			},
			{
				"<leader>-",
				function()
					MiniFiles.open(vim.uv.cwd(), false)
				end,
				desc = "Open mini.files (target cwd)",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesExplorerOpen",
				callback = function()
					MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
					MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
					MiniFiles.set_bookmark("~", "~", { desc = "Home directory" })
				end,
			})
		end,
		opts = {
			use_as_default_explorer = false,
			mappings = {
				go_in = "L",
				go_in_plus = "l",
			},
			windows = {
				width_focus = 30,
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		version = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			local ai = require("mini.ai")

			ai.setup({
				n_lines = 500,
				mappings = {
					-- disable because not likely to use
					around_next = "",
					inside_next = "",
					around_last = "",
					inside_last = "",
				},
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comment

					d = { "%f[%d]%d+" }, -- digits
					e = { -- word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					-- TODO: 0.13 can remove this, use il/al instead
					g = function() -- entire buffer
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line("$"),
							col = math.max(vim.fn.getline("$"):len(), 1),
						}
						return { from = from, to = to }
					end,
				},
			})
		end,
	},
}
