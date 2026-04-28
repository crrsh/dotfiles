return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerToggle", "OverseerRun", "OverseerShell" },
	keys = {
		{ "<leader>oo", "<cmd>OverseerToggle<cr>" },
		{ "<leader>or", "<cmd>OverseerRun<cr>" },
		{ "<leader>os", "<cmd>OverseerShell<cr>" },
		{ "<leader>ot", "<cmd>OverseerTaskAction<cr>" },
	},
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {},
}
