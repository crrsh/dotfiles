return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
	keys = {
    -- stage/unstage/reset hunks
		{ "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>" },
    { "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = { "v" } },
    { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>" },
		{ "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>" },
    { "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = { "v" } },
    { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>" },

    -- preview hunk
		{ "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>" },
		{ "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>" },

    -- more detailed blame
		{ "<leader>b", function() require("gitsigns").blame_line({ full = true }) end },

    -- diffs
    -- TODO: codediff.nvim instead?
		{ "<leader>hd", "<cmd>Gitsigns diffthis<cr>" },
		{ "<leader>hD", function() require("gitsigns").diffthis("~") end },

		-- hunk as a textobject
		{ "ih", "<cmd>Gitsigns select_hunk<cr>", mode = { "x", "o" } },

		-- navigation
		{ "[h", "<cmd>Gitsigns nav_hunk prev<cr>" },
    { "]h", "<cmd>Gitsigns nav_hunk next<cr>" },
		{ "[H", "<cmd>Gitsigns nav_hunk first<cr>" },
		{ "]H", "<cmd>Gitsigns nav_hunk last<cr>" },
	},
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			topdelete = { show_count = true },
			delete = { show_count = true },
		},
		signs_staged = {
			add = { text = "▎" },
			change = { text = "▎" },
			topdelete = { show_count = true },
			delete = { show_count = true },
		},
		attach_to_untracked = true,
		count_chars = {
			[1] = "", -- ₁
			[2] = "₂",
			[3] = "₃",
			[4] = "₄",
			[5] = "₅",
			[6] = "₆",
			[7] = "₇",
			[8] = "₈",
			[9] = "₉",
			["+"] = "₊",
		},
	},
}
