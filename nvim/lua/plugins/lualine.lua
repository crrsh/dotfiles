local _filename

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	event = "UIEnter",
	opts = {
		options = {
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_c = {
				{
					function()
						_filename = _filename or require("lualine.components.filename"):new({ path = 0 })
						return vim.b.term_title or _filename:update_status()
					end,
				},
			},
			lualine_x = {
				{
					function()
						return "@" .. vim.fn.reg_recording()
					end,
					cond = function()
						return vim.fn.reg_recording() ~= ""
					end,
				},
				{ "searchcount" },
				{ "lsp_status" },
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
			callback = function()
				require("lualine").refresh()
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "NoHlSearch",
			callback = function()
				require("lualine").refresh()
			end,
		})
	end,
}
