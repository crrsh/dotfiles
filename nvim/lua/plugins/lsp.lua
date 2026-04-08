return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
		build = ":MasonUpdate",
		opts = {
			-- NOTE: waiting on https://github.com/mason-org/mason.nvim/pull/1640
			-- pip = { use_uv = true },
			ui = {
				height = 0.8,
				icons = {
					package_installed = "●",
					package_pending = "○",
					package_uninstalled = "○",
				},
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
		init = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(
						0,
						"DiagnosticUnderlineHint",
						{ undercurl = false, underline = false, update = true }
					)
				end,
			})
		end,
		config = function()
			vim.diagnostic.config({
				virtual_text = { current_line = true },
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
						[vim.diagnostic.severity.ERROR] = "DiagnosticError",
						[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticHint",
					},
				},
				float = { source = "if_many" },
			})

			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						showSyntaxErrors = false, -- leave this to ty
					},
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
