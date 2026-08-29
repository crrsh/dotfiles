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
			alpha = { after = true },
		},
		config_internal_pairs = {
			{ '"', '"', alpha = true },
			{ "'", "'", alpha = true },
			{ "`", "`", alpha = true },
		},
	},
}
