return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			pip = { upgrade_pip = true },
			ui = {
				border = "rounded",
				height = 0.8,
				icons = {
					package_installed = "●",
					package_pending = "○",
					package_uninstalled = "○",
				},
				keymaps = { toggle_help = "?" },
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = { "lua_ls", "stylua", "ruff", "ty" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				update_in_insert = true,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
						[vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
					},
				},
				float = {
					header = "",
					-- border = "rounded",
					source = "if_many",
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
