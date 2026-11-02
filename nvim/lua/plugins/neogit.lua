return {
	"NeogitOrg/neogit",
	cmd = { "Neogit", "NeogitCommit", "NeogitLog", "NeogitResetState" },
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		{ "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Neogit branch popup" },
		{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit popup" },
		{ "<leader>gr", "<cmd>Neogit rebase<cr>", desc = "Neogit rebase popup" },
		{ "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit pull popup" },
		{ "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit push popup" },
		{ "<leader>gz", "<cmd>Neogit stash<cr>", desc = "Neogit stash popup" },
		{
			"<leader>ge",
			function()
				require("neogit").action("commit", "extend")()
			end,
			desc = "Extend last commit with staged",
		},
		{
			"<leader>gF",
			function()
				require("neogit").action("commit", "instant_fixup")()
			end,
			desc = "Instant fixup",
		},
	},
	opts = {
		treesitter_diff_highlight = true,
		graph_style = "kitty",
		initial_branch_name = "",
		auto_show_console_on = "error",
		integrations = { snacks = false },
	},
}
