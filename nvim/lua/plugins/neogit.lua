return {
	"NeogitOrg/neogit",
	cmd = { "Neogit", "NeogitCommit", "NeogitLog", "NeogitResetState" },
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		{ "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Neogit branch popup" },
		{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit popup" },
		{ "<leader>gr", "<cmd>Neogit rebase<cr>", desc = "Neogit rebase popup" },
	},
	opts = {
		integrations = { snacks = false },
	},
}
