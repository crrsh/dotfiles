return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	keys = {
		"<c-cr>",
		{ "<c-\\>", "<c-\\><c-n>", mode = "t" },
		{
			"t<cr>",
			"<cmd>exe v:count . 'TermExec cmd=' . shellescape(getline('.'))<cr>",
			desc = "ToggleTerm send current line",
		},
		{
			"t<cr>",
			'<cmd>exe v:count . \'TermExec cmd=\' . shellescape(join(getline("\'<", "\'>"), "\\n"))<cr>',
			desc = "ToggleTerm send visual selection",
			mode = "v",
		},
	},
	opts = {
		open_mapping = "<c-cr>",
	},
	init = function()
		vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = function()
				local leader = "<c-b>"
				vim.keymap.set("t", leader .. "s", function()
					local id = vim.b.toggle_number
					vim.cmd(id .. "ToggleTerm")
					vim.cmd(id .. "ToggleTerm direction=horizontal size=12")
				end, { desc = "ToggleTerm change to horizontal" })
				vim.keymap.set("t", leader .. "v", function()
					local id = vim.b.toggle_number
					vim.cmd(id .. "ToggleTerm")
					vim.cmd(id .. "ToggleTerm direction=vertical size=50")
				end, { desc = "ToggleTerm change to vertical" })
				vim.keymap.set("t", leader .. "f", function()
					local id = vim.b.toggle_number
					vim.cmd(id .. "ToggleTerm")
					vim.cmd(id .. "ToggleTerm direction=float")
				end, { desc = "ToggleTerm change to float" })
				vim.keymap.set("t", leader .. "t", function()
					local id = vim.b.toggle_number
					vim.cmd(id .. "ToggleTerm")
					vim.cmd(id .. "ToggleTerm direction=tab")
				end, { desc = "ToggleTerm change to tab" })
				vim.keymap.set(
					"t",
					leader .. "r",
					"<cmd>exe b:toggle_number . 'ToggleTermSetName'<cr>",
					{ desc = "ToggleTerm rename" }
				)
			end,
		})
	end,
}
