return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		keys = {
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment", },
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
