return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{ "<leader>cf", "<cmd>Format<cr>", mode = { "n", "x" }, silent = true, desc = "Format buffer or range" },
		{ "<leader>tf", "<cmd>AutoFormat<cr>", desc = "Toggle auto format on save" },
		{ "<leader>tF", "<cmd>AutoFormat buffer<cr>", desc = "Togle auto format on save for current buffer" },
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			markdown = { "injected" },
			["_"] = { "trim_whitespace" },
			-- TODO: test this one out
			-- ["*"] = { "codespell" },
		},
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500 }
		end,
	},
	init = function()
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line and end_line:len() },
				}
			end
			require("conform").format({ async = true, range = range })
		end, { range = true, desc = "Format buffer or range" })

		vim.api.nvim_create_user_command("AutoFormat", function(args)
			local buf = args.args == "buffer"
			local opt = vim.g
			if buf then
				opt = vim.b
			end
			opt.disable_autoformat = not opt.disable_autoformat
			local status = opt.disable_autoformat and "off" or "on"
			local bufname = buf and " [" .. vim.fn.expand("%:t") .. "]" or ""
			vim.notify("Autoformat " .. status .. bufname, vim.log.levels.INFO)
		end, {
			nargs = "?",
			complete = function()
				return { "buffer" }
			end,
			desc = "Toggle autoformat (global or buffer)",
		})
	end,
}
