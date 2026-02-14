-- +------------------------+
-- | Toggles                |
-- +------------------------+
-- TODO:

-- +------------------------+
-- | Centered cursor        |
-- +------------------------+

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- +------------------------+
-- | Yank / Paste           |
-- +------------------------+

-- fix indentation on paste
-- TODO: possibly makes more sense as autocmd?
local function indent_paste(cmd, register)
	return function()
		local linewise = vim.fn.getregtype(register):sub(1, 1) == "V"
		vim.cmd("normal! " .. cmd)
		if linewise then
			vim.cmd("normal! =`]^") -- fix indent if linewise
		end
	end
end

vim.keymap.set("n", "p", indent_paste("p", '"'))
vim.keymap.set("x", "p", indent_paste('"_dP', '"')) -- don't yank on put

-- yank/paste from system clipboard
vim.keymap.set("n", "<leader>p", indent_paste('"+p', "+"))
vim.keymap.set("x", "<leader>p", indent_paste('"_d"+P', "+")) -- don't yank on put
vim.keymap.set("n", "<leader>P", indent_paste('"+P', "+"))
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- +------------------------+
-- | Windows                |
-- +------------------------+

-- jump between windows
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- resizing windows
-- TODO: probably just arrow keys?

-- +------------------------+
-- | Unorganised           |
-- +------------------------+
--
-- indent visually selection multiple times
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- more ergonmic ^ and $
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

-- TODO: clashes
-- quicker movement with J K
-- vim.keymap.set({ "n", "x", "o" }, "J", "6j", { remap = true })
-- vim.keymap.set({ "n", "x", "o" }, "K", "6k", { remap = true })
-- vim.keymap.set("n", "<c-k>", function() -- replacement for overwritten K default keymap
-- 	vim.lsp.buf.hover()
-- end)

-- treat wrapped lines as if they aren't
vim.keymap.set({ "n", "x", "o" }, "j", "gj")
vim.keymap.set({ "n", "x", "o" }, "k", "gk")

-- TODO: mainly thinking for escaping brackets but maybe tabout.nvim is better
-- move cursor in insert mode
vim.keymap.set("i", "<c-h>", "<c-o>h")
vim.keymap.set("i", "<c-l>", "<c-o>a")
