vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- add "CursorHold" to be more aggressive
	group = vim.api.nvim_create_augroup("autoreload", { clear = true }),
	desc = "Keep buffer contents updated",
	command = "if mode() != 'c' | checktime | endif",
})

local term = vim.api.nvim_create_augroup("term", { clear = true })
vim.api.nvim_create_autocmd("WinLeave", {
	group = term,
	desc = "Remember terminal mode",
	pattern = "term://*",
	callback = function()
		vim.b.term_mode = vim.api.nvim_get_mode().mode == "t"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = term,
	desc = "Restore terminal mode",
	pattern = "term://*",
	callback = function()
		if vim.b.term_mode then
			vim.cmd.startinsert()
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = term,
	desc = "Open terminal in insert mode",
	callback = function()
		vim.b.term_mode = true
		vim.cmd.startinsert()
	end,
})
