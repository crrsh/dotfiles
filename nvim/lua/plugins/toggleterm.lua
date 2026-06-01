local function setup_termjump()
	local termjump = nil

	vim.api.nvim_create_user_command("TermJump", function()
		local function close_termjump()
			if termjump then
				vim.api.nvim_win_close(termjump, true)
				termjump = nil
			end
		end
		local function render_lines(buf, terms)
			local max_width = 0
			local lines = { "" }
			for _, t in ipairs(terms) do
				local name = t.display_name or t.name
				if #name > max_width then
					max_width = #name
				end
				table.insert(lines, string.format("   %s %s", t.id, name))
			end

			local width = max_width + 10
			local height = #terms + 2

			if #terms == 0 then
				local no_terms_msg = "   No terms yet."
				table.insert(lines, no_terms_msg)
				max_width = #no_terms_msg
				width = width + #no_terms_msg - 8
				-- width = width - 8
				height = height + 1
			end
			table.insert(lines, "")
			vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			local row = math.ceil((vim.o.lines - height) / 2)
			local col = math.ceil((vim.o.columns - width) / 2)
			local win_opts = { relative = "editor", height = height, width = width, row = row, col = col }
			if termjump then
				vim.api.nvim_win_set_config(termjump, win_opts)
			else
				termjump = vim.api.nvim_open_win(
					buf,
					true,
					vim.tbl_extend("force", win_opts, {
						style = "minimal",
						border = (vim.o.winborder ~= "" and vim.o.winborder) or "single",
					})
				)
			end
			vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
		end
		-- toggles window
		if termjump then
			close_termjump()
			return
		end

		local buf = vim.api.nvim_create_buf(false, true)

		local terms = require("toggleterm.terminal").get_all()
		render_lines(buf, terms)

		-- make cursor invisible in float
		vim.api.nvim_set_hl(0, "TermJumpCursor", { nocombine = true, blend = 100 })
		vim.opt.guicursor:append("a:TermJumpCursor/TermJumpCursor")

		vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })

		local mode
		local keymap_opts = { buffer = buf, noremap = true, silent = true, nowait = true }

		vim.keymap.set("n", "q", function()
			close_termjump()
		end, keymap_opts)

		vim.keymap.set("n", "<esc>", function()
			close_termjump()
		end, keymap_opts)

		local function select_term_id(id)
			if id == "n" then
				id = require("toggleterm.terminal").next_id()
			end
			local term = require("toggleterm.terminal").get_or_create_term(tonumber(id))
			local direction
			local size
			if mode == "rename" then
				vim.ui.input({ prompt = "rename to: " }, function(input)
					if input then
						vim.cmd(id .. "ToggleTermSetName " .. input)
					end
				end)
				terms = require("toggleterm.terminal").get_all()
				render_lines(buf, terms)
				mode = nil
				return
			elseif mode == "delete" then
				term:shutdown()
				terms = require("toggleterm.terminal").get_all()
				render_lines(buf, terms)
				mode = nil
				return
			elseif mode == "split" then
				direction = "horizontal"
				size = math.floor(vim.o.lines * 0.2)
			elseif mode == "vertical" then
				direction = "vertical"
				size = math.floor(vim.o.columns * 0.2)
			elseif mode == "float" then
				direction = "float"
			elseif mode == "tab" then
				direction = "tab"
			elseif mode == "paste" then
				local yanked = vim.fn.getreg('"')
				term:send(yanked)
			end
			close_termjump()
			if term:is_open() then
				term:close()
			end
			term:open(size, direction)
		end

		local function toggle_mode(m)
			mode = mode == m and nil or m
		end

		vim.keymap.set("n", "s", function()
			toggle_mode("split")
		end, keymap_opts)

		vim.keymap.set("n", "v", function()
			toggle_mode("vertical")
		end, keymap_opts)

		vim.keymap.set("n", "f", function()
			toggle_mode("float")
		end, keymap_opts)

		vim.keymap.set("n", "t", function()
			toggle_mode("tab")
		end, keymap_opts)

		vim.keymap.set("n", "r", function()
			toggle_mode("rename")
		end, keymap_opts)

		vim.keymap.set("n", "d", function()
			toggle_mode("delete")
		end, keymap_opts)

		vim.keymap.set("n", "p", function()
			toggle_mode("paste")
		end, keymap_opts)

		vim.keymap.set("n", "C", function()
			for _, t in ipairs(terms) do
				t:shutdown()
			end
			close_termjump()
		end, keymap_opts)

		for _, id in ipairs({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "n" }) do -- `n` for new
			vim.keymap.set("n", id, function()
				select_term_id(id)
			end, keymap_opts)
		end

		vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
			buffer = buf,
			desc = "Disable Cursor",
			once = true,
			callback = function()
				vim.cmd("highlight clear TermJumpCursor")
				vim.schedule(function()
					vim.opt.guicursor:remove("a:TermJumpCursor/TermJumpCursor")
				end)
				close_termjump()
			end,
		})
	end, { desc = "ToggleTerm jump" })
	vim.keymap.set("n", "\\", "<cmd>TermJump<cr>")
end

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

		setup_termjump()
	end,
}
