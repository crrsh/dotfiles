return {
	"nvim-mini/mini.files",
	dependencies = { "nvim-mini/mini.icons", opts = {} },
	keys = {
		{
			"-",
			function()
				if not MiniFiles.close() then
					local path = vim.api.nvim_buf_get_name(0)
					if vim.fn.filereadable(path) == 0 then
						path = vim.fn.fnamemodify(path, ":h")
					end
					MiniFiles.open(path, false)
				end
			end,
			desc = "Toggle mini.files (target buf dir)",
		},
		{
			"<leader>-",
			function()
				MiniFiles.open(vim.uv.cwd(), false)
			end,
			desc = "Open mini.files (target cwd)",
		},
	},
	opts = {
		mappings = {
			go_in = "L",
			go_in_plus = "l",
		},
		windows = {
			width_focus = 30,
		},
	},
}
