return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	enabled = false,
	opts = {
		keymaps = { -- TODO: keymaps yet to be confirmed - conflicting with flash.nvim
			-- i would be fine with defaults if i can settle on a different keymap for flash jump()
			--                 -- like <cr> or <tab> or <ctrl-space> ???
			normal = "gs", -- go surround
			normal_cur = "gss",
			normal_cur_lines = "gSS", -- this one does not work
			visual = "gs",
			visual_line = "gS",
			delete = "dis", -- delete surround
			change = "cis", -- change surround
		},
	},
}
