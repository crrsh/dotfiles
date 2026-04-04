local function get_mini_file_icon(ctx)
	if ctx.source_name == "Path" then
		local is_unknown_type =
			vim.tbl_contains({ "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
		local mini_icon, mini_hl, _ = require("mini.icons").get(
			is_unknown_type and "os" or ctx.item.data.type,
			is_unknown_type and "" or ctx.label
		)
		if mini_icon then
			return mini_icon or nil, mini_hl
		end
	end
end

return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim",
		"nvim-mini/mini.icons",
	},
	event = { "InsertEnter", "CmdlineEnter" },
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = { "lsp", "path" },
		},
		completion = {
			menu = {
				max_height = 8,
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						kind_icon = {
							text = function(ctx)
								local mini_icon, _ = get_mini_file_icon(ctx)
								return mini_icon or ctx.kind_icon
							end,
							highlight = function(ctx)
								local _, mini_hl = get_mini_file_icon(ctx)
								return mini_hl or require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
		},
		signature = {
			enabled = true,
			trigger = { enabled = false }, -- trigger manually with Ctrl-k
			window = {
				show_documentation = false,
				direction_priority = { "n", "s" }, -- keep out of the way of completion menu
			},
		},
		keymap = {
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-s>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
	},
	opts_extend = { "sources.default" },
}
