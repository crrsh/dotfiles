return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-mini/mini.icons",
	},
	ft = { "markdown" },
	keys = {
		{ "<leader>um", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Markdown: toggle render" },
		{ "<leader>uM", "<cmd>RenderMarkdown preview<cr>", desc = "Markdown: toggle side preview" },
	},
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		render_modes = true,
		anti_conceal = {
			ignore = { head_background = true },
		},
		completions = { lsp = { enabled = true } },
		heading = {
			icons = {},
			width = "block",
			right_pad = 1,
		},
		code = {
			disable_background = false,
			sign = false,
			width = "block",
			highlight_language = "NonText",
			highlight_info = "NonText",
			language_pad = 1,
			right_pad = 1,
			min_width = 60,
			border = "thin",
		},
		pipe_table = { preset = "round" },
	},
}
