-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	ui = vim.o.winborder ~= "" and { border = vim.o.winborder } or {},
	install = {
		colorscheme = { vim.g.colors_name, "default" },
	},
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})

-- Remove border from backdrop buffer
-- can be removed after (https://github.com/folke/lazy.nvim/pull/2072)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazy_backdrop",
	callback = function(args)
		local win = vim.fn.win_findbuf(args.buf)[1]
		vim.api.nvim_win_set_config(win, { border = "none" })
	end,
})
