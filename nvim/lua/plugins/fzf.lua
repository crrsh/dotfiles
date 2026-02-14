return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	cmd = "FzfLua",
	keys = {
		-- Buffers and Files
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find open buffers" },
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>fh", "<cmd>FzfLua oldfiles<cr>", desc = "Find opened files" },
		{ "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Find quickfix list" },
		{ "<leader>fQ", "<cmd>FzfLua quickfix_stack<cr>", desc = "Find quickfix list stack" },
		{ "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Find location list" },
		{ "<leader>fL", "<cmd>FzfLua loclist_stack<cr>", desc = "Find location list stack" },

		-- Search
		{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word" },
		{ "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Grep WORD" },
		{ "<leader>fg", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Grep visual selection" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
		{ "<leader>fG", "<cmd>FzfLua live_grep_resume<cr>", desc = "Resume live grep" },

		-- Git
		-- NOTE: these may not stick around - may go with fugitive/lazygit for most of this
		{ "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Find git files" },
		{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
		{ "<leader>gh", "<cmd>FzfLua git_commits<cr>", desc = "Git history" },
		{ "<leader>gH", "<cmd>FzfLua git_bcommits<cr>", desc = "Git buffer history" },
		{ "<leader>gc", "<cmd>FzfLua git_branches<cr>", desc = "Git checkout branch" },
		{ "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git stash" },

		-- Misc
		{ "<leader>fF", "<cmd>FzfLua resume<cr>", desc = "Resume previous search" },
		{ "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Change colorscheme" },
		{ "<leader>?", "<cmd>FzfLua keymaps<cr>", desc = "Search keymaps" },

		-- nvim-dap
		-- TODO: only after looking into nvim-dap

		-- Zoxide
		{ "<leader>z", "<cmd>FzfLua zoxide<cr>", desc = "Zoxide" },
	},
	opts = {
		keymap = {
			builtin = { -- more ergo keymaps for navigating preview
				["<c-d>"] = "preview-page-down",
				["<c-u>"] = "preview-page-up",
				["<c-j>"] = "preview-down",
				["<c-k>"] = "preview-up",
			},
			fzf = {
				["ctrl-q"] = "select-all+accept", -- send all to qflist
			},
		},
		defaults = { file_icons = "mini" },
		-- TODO: image preview
		-- TODO: move cursor to preview?
	},
}
