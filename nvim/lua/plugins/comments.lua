return {
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "folke/trouble.nvim" },
		event = "VeryLazy",
    -- stylua: ignore
		keys = {
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "<leader>xt", "<cmd>:Trouble todo toggle<cr>", desc = "Trouble todo" },
		},
		opts = {
			keywords = {
				FIX = { alt = { "fix", "fixme", "bug", "fixit", "issue" } },
				TODO = { alt = { "todo" } },
				HACK = { alt = { "hack" } },
				WARN = { alt = { "warn", "warning", "xxx" } },
				PERF = { alt = { "perf", "optim", "performance", "optimize" } },
				NOTE = { alt = { "note", "info" } },
				TEST = { alt = { "test", "testing", "passed", "failed" } },
			},
			signs = false,
			highlight = {
				keyword = "wide_fg",
				after = "none",
			},
		},
	},
}
