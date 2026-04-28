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
	opts = {
		task_list = {
			keymaps = {
				-- change keys for scrolling preview since I use the defaults for jumping between windows
				["<C-k>"] = false,
				["<C-j>"] = false,
				["K"] = "keymap.scroll_output_up",
				["J"] = "keymap.scroll_output_down",
				-- quicker actions
				["r"] = { "keymap.run_action", opts = { action = "restart" }, desc = "Restart task" },
				["R"] = { "keymap.run_action", opts = { action = "retain" }, desc = "Retain task" },
				["w"] = { "keymap.run_action", opts = { action = "watch" }, desc = "Watch task" },
				["u"] = { "keymap.run_action", opts = { action = "unwatch" }, desc = "Unwatch task" },
				["e"] = { "keymap.run_action", opts = { action = "ensure" }, desc = "Ensure task" },
			},
		},
	},
}
