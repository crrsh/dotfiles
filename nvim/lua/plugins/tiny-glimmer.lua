return {
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	priority = 10, -- low priority to catch other plugins' keybindings
	opts = {
		overwrite = {
			yank = { default_animation = "fade" },
			undo = { enabled = true },
			redo = { enabled = true },
		},
	},
}
