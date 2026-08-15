local function grep_directory()
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

	Snacks.picker({
		title = "Grep in directory",
		items = items,
		confirm = function(picker, item)
			picker:close()
			Snacks.picker.grep({ dirs = { item.file } })
		end,
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
  -- stylua: ignore
	keys = {
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
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
		{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
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
		{ "<leader>sG", grep_directory, desc = "Grep directory" },
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
	},
	init = function()
		vim.api.nvim_set_hl(0, "SnacksInputNormal", { link = "NormalFloat" })
		vim.api.nvim_set_hl(0, "SnacksInputBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "SnacksInputTitle", { link = "FloatTitle" })
		vim.api.nvim_set_hl(0, "SnacksInputIcon", { link = "FloatBorder" })
	end,
}
