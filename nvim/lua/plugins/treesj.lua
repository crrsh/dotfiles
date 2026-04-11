return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- stylua: ignore
  keys = {
    { "<leader>z", function() require("treesj").toggle() end },
  },
	opts = {
		use_default_keymaps = false,
		notify = false,
	},
}
