return {
	"folke/flash.nvim",
	enabled = false,
	event = "VeryLazy",
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<leader>s",
			function()
				require("flash").jump({ pattern = vim.fn.expand("<cword>") })
			end,
			desc = "Flash cword",
		},
	},
	opts = {
		label = {
			current = false,
			after = false,
			before = true, -- trying label before - won't move as you type
		},
		highlight = {
			groups = {
				-- TODO: make sure it looks nice in all themes - see :h flash
				-- i like how catppuccin looks
			},
		},
		modes = {
			char = {
				highlight = { backdrop = false },
				-- TODO: disable highlighting matches?
			},
		},
		prompt = { enabled = false }, -- TODO: maybe show in lualine instead?
	},
}
