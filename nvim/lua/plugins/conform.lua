return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{ "<leader>cf", "<cmd>Format<cr>", mode = { "n", "x" }, silent = true, desc = "Format buffer or range" },
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			markdown = { "injected" },
			["_"] = { "trim_whitespace" },
		},
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = function(bufnr)
			if vim.g.autoformat and vim.b[bufnr].autoformat ~= false then
				return { timeout_ms = 500 }
			end
		end,
	},
	init = function()
		vim.g.autoformat = true

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

		vim.api.nvim_create_user_command("FormatToggle", function(args)
			local opt = vim.g
			if args.bang then
				opt = vim.b
			end
			opt.autoformat = opt.autoformat == false
			local status = opt.autoformat and "on" or "off"
			local bufname = args.bang and " [" .. vim.fn.expand("%:t") .. "]" or ""
			vim.notify("Autoformat " .. status .. bufname, vim.log.levels.INFO)
		end, { bang = true, desc = "Toggle autoformat" })

		vim.api.nvim_create_user_command("FormatEnable", function(args)
			if args.bang then
				vim.b.autoformat = true
			else
				vim.g.autoformat = true
			end
		end, { bang = true, desc = "Enable autoformat" })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.autoformat = false
			else
				vim.g.autoformat = false
			end
		end, { bang = true, desc = "Disable autoformat" })
	end,
}
