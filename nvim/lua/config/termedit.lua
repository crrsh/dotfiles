-- edit typed term cmd in scratch buffer and update terminal buffer on close
-- requires fish bind ctrl-g -> suppress-autosuggestion
-- todo: support other shells
-- todo: don't require specific shell configs or bindings
-- todo: pin/attach to term buffers so when they are hidden this scratch buffer is also
-- todo: support floating terms (open in float rather than split)
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(args)
		local term_buf = args.buf
		local term_win = vim.api.nvim_get_current_win()
		local term_job_id = vim.b[term_buf].terminal_job_id

		vim.api.nvim_create_autocmd("TermRequest", {
			buffer = term_buf,
			callback = function(args2)
				if string.match(args2.data.sequence, "^\027]133;B") then
					local cursor = args2.data.cursor
					-- prompt width can change so need to recalculate each time
					local prompt = vim.api.nvim_buf_get_lines(args2.buf, cursor[1] - 1, cursor[1], true)[1]
					vim.b[args2.buf].prompt_width = prompt and vim.str_byteindex(prompt, "utf-32", cursor[2]) or 0
					vim.b[args2.buf].cmd_cursor = cursor
				end
			end,
		})

		local function get_current_cmd(buf, cmd_cursor)
			local lines = vim.api.nvim_buf_get_lines(buf, cmd_cursor[1] - 1, -1, true)

			local cmd = {}
			for i, line in ipairs(lines) do
				if i == 1 then
					local prompt_width = vim.b[buf].prompt_width
					table.insert(cmd, line:sub(prompt_width + 1))
				else
					table.insert(cmd, line)
				end
				local is_last = lines[i + 1] == "" and lines[i + 2] == ""
				if is_last then
					break
				end
			end

			return cmd
		end

		local function open_split(cmd)
			local term_cur = vim.api.nvim_win_get_cursor(term_win)

			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, cmd)
			vim.api.nvim_buf_set_name(buf, vim.fn.tempname())
			vim.bo[buf].buftype = "acwrite"
			vim.bo[buf].bufhidden = "wipe"
			vim.bo[buf].modified = false
			vim.bo[buf].filetype = "fish"

			local win_opts = { split = "below", height = #cmd + 2 }
			local win = vim.api.nvim_open_win(buf, true, win_opts)
			vim.wo[win].winfixheight = true

			-- compute cursor position relative to cmd start
			local cmd_cursor = vim.b[term_buf].cmd_cursor
			local prompt_width = vim.b[term_buf].prompt_width
			local split_row = term_cur[1] - cmd_cursor[1] + 1
			local split_col = term_cur[2]
			if term_cur[1] == cmd_cursor[1] then
				split_col = math.max(0, term_cur[2] - prompt_width)
			end
			vim.api.nvim_win_set_cursor(win, { split_row, split_col })

			vim.api.nvim_create_autocmd("BufWriteCmd", {
				buffer = buf,
				callback = function()
					vim.bo[buf].modified = false
				end,
			})
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(win),
				once = true,
				callback = function()
					local edited = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
					-- send edited cmd
					vim.api.nvim_chan_send(term_job_id, table.concat(edited, "\n"))
					vim.api.nvim_set_current_win(term_win)
					vim.cmd("startinsert!")
				end,
			})
		end

		local function edit_term()
			local buf = vim.api.nvim_get_current_buf()
			local cmd_cursor = vim.b[buf].cmd_cursor

			-- send ctrl-g to suppress-autosuggestion
			vim.api.nvim_chan_send(term_job_id, "\x07")

			vim.defer_fn(function()
				local cmd = get_current_cmd(buf, cmd_cursor)
				-- send ctrl-c
				vim.api.nvim_chan_send(term_job_id, "\x03")
				open_split(cmd)
			end, 20)
		end

		vim.keymap.set("t", "<a-e>", edit_term, { buffer = term_buf })
		vim.keymap.set("t", "<c-e>", edit_term, { buffer = term_buf })
	end,
})
