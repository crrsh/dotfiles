return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	opts = {
		space2 = { enable = true },
		extensions = {
			filetype = {
				nft = { "snacks_picker_input" },
			},
			alpha = { alpha = true, after = true },
		},
	},
}
