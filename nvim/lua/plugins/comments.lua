return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {},
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		enabled = false,
		keys = {
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
		},
		opts = {
			signs = false,
			highlight = {
				keyword = "wide_fg",
				after = "none",
			},
		},
	},
}
