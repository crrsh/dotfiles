-- disable defaults
vim.keymap.set("n", "<bs>", "<nop>")
vim.keymap.set("n", "<space>", "<nop>")

-- centered cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- fix indentation on paste
-- TODO: commented out because unpredictable
--       fix this or use smart-indent.nvim and map to =p or something like that
-- local function indent_paste(cmd, register)
-- 	return function()
-- 		local linewise = vim.fn.getregtype(register):sub(1, 1) == "V"
-- 		vim.cmd("normal! " .. cmd)
-- 		if linewise then
-- 			vim.cmd("normal! =`]^") -- fix indent if linewise
-- 		end
-- 	end
-- end
-- vim.keymap.set("n", "p", indent_paste("p", '"'))
-- vim.keymap.set("x", "p", indent_paste('"_dP', '"')) -- don't yank on put
--
-- vim.keymap.set("n", "<leader>p", indent_paste('"+p', "+"))
-- vim.keymap.set("x", "<leader>p", indent_paste('"_d"+P', "+")) -- don't yank on put
-- vim.keymap.set("n", "<leader>P", indent_paste('"+P', "+"))

-- yank/paste from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

-- don't yank on put
vim.keymap.set("x", "p", '"_dP')
vim.keymap.set("x", "<leader>p", '"_d"+P')

-- paste charwise on new line
local function paste_on_new_line(cmd)
	local reg = vim.v.register
	local body = vim.fn.getreg(reg)
	local regtype = vim.fn.getregtype(reg)
	vim.fn.setreg(reg, body, "l")
	vim.cmd('normal! "' .. reg .. cmd)
	vim.fn.setreg(reg, body, regtype)
end
vim.keymap.set("n", "]p", function()
	paste_on_new_line("]p")
end)
vim.keymap.set("n", "[p", function()
	paste_on_new_line("[p")
end)

-- move between windows
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- resizing windows
-- TODO: probably just arrow keys?

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

-- quickly disable hlsearch
vim.keymap.set("n", "<esc>", function()
	vim.cmd("nohlsearch")
	vim.api.nvim_exec_autocmds("User", { pattern = "NoHlSearch" })
end)

-- jump between diagnostics
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev Diagnostic" })
