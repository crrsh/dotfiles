return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	dependencies = { "nvim-mini/mini.icons" },
	event = "UIEnter",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ -- show first character of mode
						"mode",
						fmt = function(res)
							return res:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					"branch",
					"diff", -- TODO: pure prompt like so show if branch dirty
					"diagnostics",
				},
				lualine_c = { "filename" },
				-- TODO: if going with something like this - disable dashed gitsigns for untracked
				-- lualine_c = {
				-- 	{
				-- 		"filename",
				-- 		symbols = {
				-- 			modified = "[+]",
				-- 			readonly = "[-]",
				-- 			unnamed = "[No Name]",
				-- 		},
				-- 		fmt = function(str)
				-- 			if vim.bo.buftype ~= "" or vim.fn.expand("%") == "" then
				-- 				return str
				-- 			end
				--
				-- 			local git_dir = vim.fn.finddir(".git", ".;")
				-- 			if git_dir == "" then
				-- 				return str
				-- 			end
				--
				-- 			local file = vim.fn.expand("%:p")
				-- 			vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(file) .. " 2>/dev/null")
				--
				-- 			if vim.v.shell_error ~= 0 then
				-- 				return "󰋗 " .. str
				-- 			end
				--
				-- 			return str
				-- 		end,
				-- 	},
				-- },
				lualine_x = {
					{ -- show shortened @recording messages
						function()
							local mode = require("noice").api.status.mode.get()
							return mode:gsub("^recording%s*", "")
						end,
						cond = function()
							return vim.fn.reg_recording() ~= ""
						end,
						color = { fg = "#ff9e64" }, -- TODO: pull colors from current theme (or use none)
					},
					-- "encoding",
					-- "fileformat",
					-- -- "filetype",
				},
				lualine_y = {
					-- "diagnostics", -- NOTE: not a default
					-- { -- NOTE: also not default
					-- 	"lsp_status",
					-- 	icon = "",
					-- 	symbols = {
					-- 		done = "",
					-- 		separator = "",
					-- 	},
					-- 	ignore_lsp = { "stylua" },
					-- },
					"progress",
				},
				lualine_z = { "location" },
			},
		})
	end,
}
