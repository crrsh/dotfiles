return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
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
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		init = function()
			-- disable entire built-in ftplugin mappings to avoid conflicts.
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			-- swap
			-- @parameter.inner
			vim.keymap.set("n", "<M-l>", function()
				swap.swap_next("@parameter.inner")
			end)
			vim.keymap.set("n", "<M-h>", function()
				swap.swap_previous("@parameter.inner")
			end)

			-- move
			-- @call.outer
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				move.goto_next_end("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end("@call.outer", "textobjects")
			end)

			-- @function.outer
			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]M", function()
				move.goto_next_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[M", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end)

			-- @class.outer
			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				move.goto_next_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				move.goto_next_end("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end("@class.outer", "textobjects")
			end)

			-- @loop.inner, @loop.outer
			vim.keymap.set({ "n", "x", "o" }, "]o", function()
				move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]o", function()
				move.goto_previous_start({ "@loop.inner", "@loop.outer" }, "textobjects")
			end)

			-- @parameter.outer
			vim.keymap.set({ "n", "x", "o" }, "]a", function()
				move.goto_next_start("@parameter.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.outer", "textobjects")
			end)

			-- @condition.outer
			-- vim.keymap.set({ "n", "x", "o" }, "]d", function()
			-- 	move.goto_next("@conditional.outer", "textobjects")
			-- end)
			-- vim.keymap.set({ "n", "x", "o" }, "[d", function()
			-- 	move.goto_previous("@conditional.outer", "textobjects")
			-- end)

			-- @local.scope
			vim.keymap.set({ "n", "x", "o" }, "]s", function()
				move.goto_next_start("@local.scope", "locals")
			end)
		end,
	},
}
