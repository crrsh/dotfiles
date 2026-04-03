return {
	"folke/noice.nvim",
	enabled = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	event = "VeryLazy",
	opts = {
		cmdline = {
			-- TODO: which?
			view = "cmdline_popup",
			-- OR
			-- view = "cmdline",
		},
		messages = {
			-- TODO: errors and warnings do not stick around for long
			-- mini i prefer for lsp progress and things
			-- i would much prefer for a permanent mini that goes away after a new command is entered or something
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
			-- view_search = "mini", -- TODO: do i want mini instead?
		},

		redirect = {
			view = "popup",
			filter = { event = "msg_show" },
		},
		notify = {
			enabled = true,
			view = "mini",
		},
		lsp = {
			override = {
				-- override the default lsp markdown formatter with Noice
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				-- override the lsp markdown formatter with Noice
				["vim.lsp.util.stylize_markdown"] = false,
				-- override cmp documentation with Noice (needs the other options to work)
				["cmp.entry.get_documentation"] = false,
			},
			hover = {
				enabled = true,
				silent = true,
			},
			signature = {
				enabled = false,
			},
			message = {
				enabled = true,
				view = "mini",
			},
		},
		health = {
			checker = false,
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			inc_rename = false, -- TODO: check out increname
			lsp_doc_border = false,
		},
		views = {
			-- see: https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
			-- TODO: view for mini top right
			--       should replace nvim-notify
			--       longer timeout than base mini view so there is time to read errors
			-- TODO: view for when a typed command fails
			--       some akin how it works pre noice
			--       long timeout if any
			--       dismissable?
			-- I want lsp progress, failed searches, toggle notifications to be mini and subtle
			-- I want longer error messages to not disappear as quick as mini does
			-- Also running :ls! and that type of thing should it be a popup? in mini?
			-- hard part is going to be routing them
		},
		routes = {},
		status = {
			-- TODO: what more status line integrations could i do?
		},
		format = {
			-- TODO: modify mini formatting to not show Info: Warn:
			--       the hl colors are enough
		},
	},
}
