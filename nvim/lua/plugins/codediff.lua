return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{ "<leader>gd", "<cmd>CodeDiff<cr>", desc = "CodeDiff" },
	},
	opts = {
		keymaps = {
			view = {
				next_file = { "]f", "<c-n>" },
				prev_file = { "[f", "<c-p>" },
			},
		},
	},
}
