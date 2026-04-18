return {
	"akinsho/toggleterm.nvim",
	keys = { [[<c-\>]] },
	opts = {
		open_mapping = [[<c-\>]],
	},
	init = function()
		vim.keymap.set("t", "<c-h>", "<cmd>wincmd h<cr>")
		vim.keymap.set("t", "<c-j>", "<cmd>wincmd j<cr>")
		vim.keymap.set("t", "<c-k>", "<cmd>wincmd k<cr>")
		vim.keymap.set("t", "<c-l>", "<cmd>wincmd l<cr>")
		vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")
	end,
}
