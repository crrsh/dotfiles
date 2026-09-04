return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
  -- stylua: ignore
	keys = {
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>/", function() Snacks.picker.lines({win = { preview = { wo = { cursorlineopt = "both" } } } }) end, desc = "Buffer Lines" },
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" }, -- TODO: duplicate
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" }, -- TODO: duplicate
		{ "<leader>.", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fF", function() Snacks.picker.files({hidden=true, ignored=true}) end, desc = "Find Files (include hidden/ignored)" },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" }, -- TODO: duplicate
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" }, -- TODO: duplicate
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- search
		{ "<leader>ss", function() Snacks.picker.grep() end, desc = "Grep" }, -- TODO: duplicate
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" }, -- TODO: duplicate
		{ "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" }, -- TODO: duplicate
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- git
		-- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" }, 
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" }, 
    -- gh
		{ "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
		{ "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
		{ "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
		{ "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
		{ "<leader>ga", function() Snacks.picker.gh_actions() end, desc = "GitHub actions (all)" },
    -- ui
		{ "<leader>uc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- custom
		{ "<leader>tt", function() Snacks.picker.terminals() end, desc = "Terminals" },
		{ "<leader>sG", function() Snacks.picker.grep_in_directory() end, desc = "Grep directory" },
		-- LSP
    -- TODO: try these out before adding
		-- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		-- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		-- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		-- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		-- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		-- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
		-- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
		-- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		-- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
	},
	opts = {
		picker = {
			ui_select = true,
			main = {
				file = false,
			},
			sources = {
				grep_in_directory = {
					finder = function()
						-- TODO: needs to support hidden or ignored folders
						-- probably don't exclude git?
						local cwd = vim.fn.getcwd()
						local dirs = {}

						if vim.fn.executable("fd") == 1 then
							dirs = vim.fn.systemlist({ "fd", "--type", "d", "--hidden", "--exclude", ".git", ".", cwd })
						elseif vim.fn.executable("find") == 1 then
              -- stylua: ignore
                dirs = vim.fn.systemlist({ "find", cwd, "-mindepth", "1", "-type", "d", "-name", ".git", "-prune", "-o", "-type", "d", "-print" })
						else
							vim.notify("No directory scanner found (fd or find)", vim.log.levels.WARN)
							return
						end

						local items = {}
						for i, dir in ipairs(dirs) do
							items[i] = { idx = i, file = dir, dir = true, text = dir }
						end

						return items
					end,
					confirm = function(item)
						Snacks.picker.grep({ dirs = { item.file } })
					end,
				},
				terminals = {
					finder = function()
						local items = {}
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
								local term_title = vim.b[buf].term_name
								if not term_title or term_title == "" then
									term_title = vim.b[buf].term_title
								end
								if not term_title or term_title == "" then
									term_title = vim.api.nvim_buf_get_name(buf)
								end
								local item = { title = term_title, buf = buf, text = term_title }
								items[#items + 1] = item
							end
						end
						return items
					end,
					format = function(item)
						local res = {}
						res[#res + 1] = { string.format("%d", item.buf), "SnacksPickerBufNr" }
						res[#res + 1] = { "   " }
						res[#res + 1] = { item.text, "SnacksPickerFile" }
						return res
					end,
					confirm = function(picker, item)
						picker:close()
						vim.api.nvim_set_current_buf(item.buf)
						vim.wo.list = false
						vim.wo.wrap = false
						vim.wo.number = false
						vim.wo.relativenumber = false
						vim.wo.signcolumn = "no"
						vim.wo.foldcolumn = "0"
						vim.wo.statusline = ""
						vim.schedule(function()
							vim.b[item.buf].term_mode = true
							vim.cmd.startinsert()
						end)
					end,
					sort_lastused = true,
					win = {
						preview = {
							wo = {
								number = false,
								relativenumber = false,
								statusline = "",
							},
						},
					},
				},
			},
		},
		explorer = {
			replace_netrw = false,
		},
		input = {
			win = {
				row = 0.4,
				keys = {
					i_up = { "<c-p>", { "hist_up" }, mode = { "i", "n" } },
					i_down = { "<c-n>", { "hist_down" }, mode = { "i", "n" } },
				},
			},
		},
		image = {},
		toggle = {
			notify = function(state, t)
				vim.api.nvim_echo({
					{ state and "Enabled " or "Disabled " },
					{ t.name, "Bold" },
				}, false, {})
			end,
		},
	},
	init = function()
		vim.api.nvim_set_hl(0, "SnacksInputNormal", { link = "NormalFloat" })
		vim.api.nvim_set_hl(0, "SnacksInputBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "SnacksInputTitle", { link = "FloatTitle" })
		vim.api.nvim_set_hl(0, "SnacksInputIcon", { link = "FloatBorder" })

		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				local zoom = Snacks.toggle.zoom()
				zoom.opts.notify = false
				zoom:map("<c-w><cr>")
				zoom:map("<c-w><c-cr>")

				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.indent():map("<leader>ui")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.words():map("<leader>uW")
				Snacks.toggle.treesitter():map("<leader>uT")

				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
			end,
		})
	end,
}
