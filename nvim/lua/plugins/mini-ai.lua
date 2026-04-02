return {
	"nvim-mini/mini.ai",
	event = "VeryLazy",
	opts = function()
		local ai = require("mini.ai")
		return {
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
					{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
					"^().*()$",
				},
				g = function() -- entire buffer
					local from = { line = 1, col = 1 }
					local to = {
						line = vim.fn.line("$"),
						col = math.max(vim.fn.getline("$"):len(), 1),
					}
					return { from = from, to = to }
				end,

				-- assignment
				-- TODO: doesn't really behave as I want
				h = ai.gen_spec.treesitter({
					a = { "@assignment.lhs", "@pair.key" },
					i = { "@assignment.lhs", "@pair.key" },
				}),
				l = ai.gen_spec.treesitter({
					a = { "@assignment.rhs", "@pair.value" },
					i = { "@assignment.rhs", "@pair.value" },
				}),
			},
		}
	end,
}
