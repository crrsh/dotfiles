return {
	"nvim-mini/mini.files",
	dependencies = { "nvim-mini/mini.icons", opts = {} },
	version = "*",
	keys = {
		{
			"-",
			function()
				if not require("mini.files").close() then
					MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				end
			end,
			desc = "Toggle mini.files (buf dir)",
		},
		{
			"<leader>-",
			function()
				require("mini.files").open(vim.loop.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
	opts = {
		mappings = {
			go_in = "",
			go_in_plus = "l",
			-- go_out = "",
			-- go_out_plus = "h",
		},
		options = {
			use_as_default_explorer = true,
			permanent_delete = false,
		},
		windows = {
			width_focus = 30,
			width_nofocus = 15, -- default
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				local config = vim.api.nvim_win_get_config(win_id)
				config.border = "rounded"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})
	end,
}
