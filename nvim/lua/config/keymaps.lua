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
--
-- vim.keymap.set("n", "<leader>p", indent_paste('"+p', "+"))
-- vim.keymap.set("n", "<leader>P", indent_paste('"+P', "+"))

-- yank/paste from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

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

-- visually select last pasted
vim.keymap.set("n", "gV", "`[v`]")

-- search visual selection
vim.keymap.set("x", "g/", "<Esc>/\\%V")

-- move between windows
vim.keymap.set({ "n", "t" }, "<c-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<c-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "t" }, "<c-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "t" }, "<c-l>", "<cmd>wincmd l<cr>")

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

-- quickly disable hlsearch
vim.keymap.set("n", "<esc>", function()
	vim.cmd("nohlsearch")
	vim.api.nvim_exec_autocmds("User", { pattern = "NoHlSearch" })
end)

-- move lines similar to vscode
vim.keymap.set("n", "<a-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<a-k>", "<cmd>m .-2<cr>==")
vim.keymap.set("x", "<a-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("x", "<a-k>", ":m '<-2<cr>gv=gv")
vim.keymap.set("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi")
vim.keymap.set("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi")
