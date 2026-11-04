return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		opts = {
			custom_highlights = function(colors)
				return {
					-- Markdown code
					["@markup.raw.markdown_inline"] = { fg = colors.lavender },
					["@markup.raw.block.markdown"] = { fg = colors.subtext1 },
					RenderMarkdownCodeInline = { bg = colors.mantle },
					RenderMarkdownCode = { bg = colors.mantle },
					RenderMarkdownCodeBorder = { bg = colors.mantle },
				}
			end,
		},
	},
}
