return {
	"saghen/blink.pairs",
	dependencies = "saghen/blink.lib",
	version = "*",
	build = function()
		require("blink.pairs").download():pwait(2000)
	end,

	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		mappings = {
			disabled_filetypes = { "snacks_picker_input" },
			wrap = {
				-- move closing pair via motion
				["<C-b>"] = "motion",
				-- move opening pair via motion
				["<C-S-b>"] = "motion_reverse",
				-- swallow next TS node into pair
				["<C-S-l>"] = "treesitter",
				["<C-S-h>"] = "treesitter_reverse",
				normal_mode = {
					["<C-b>"] = "motion",
					["<C-S-b>"] = "motion_reverse",
				},
			},
		},
		highlights = {
			groups = { "BlinkPairs" }, -- no rainbow
			unmatched_group = "DiagnosticError",
			matchparen = {
				-- TODO: try this when available
				-- include_surrounding = { "delimiter" }
			},
		},
	},
}
