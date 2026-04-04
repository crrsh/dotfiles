return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = { "lsp", "path", "snippets" },
		},
		completion = {
			menu = {
				max_height = 8,
				draw = { treesitter = { "lsp" } },
			},
		},
		signature = {
			enabled = true,
			trigger = { enabled = false },
			window = {
				show_documentation = false,
				direction_priority = { "n", "s" }, -- keep out of the way of completion menu
			},
		},
		keymap = {
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
	},
	opts_extend = { "sources.default" },
}
