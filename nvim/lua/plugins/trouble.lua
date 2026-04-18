return {
	"folke/trouble.nvim",
	cmd = "Trouble",
  --stylua: ignore
	keys = {
    -- TODO: update once fixed https://github.com/folke/trouble.nvim/issues/682
    { "<leader>xx", function() if not require("trouble").is_open("diagnostics") then vim.lsp.buf.workspace_diagnostics() end vim.cmd("Trouble diagnostics toggle") end, desc = "Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "]x", "<cmd>Trouble next skip_groups=true jump=true<cr>", desc = "Trouble next" },
    { "[x", "<cmd>Trouble prev skip_groups=true jump=true<cr>", desc = "Trouble prev" },
	},
	opts = {
		modes = {
			symbols = {
				win = { size = { width = 50 } },
			},
			lsp = {
				win = { size = { width = 50 } },
			},
		},
	},
}
