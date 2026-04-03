return {
	"goolord/alpha-nvim",
	enabled = false,
	dependencies = { "echasnovski/mini.icons" },
	cmd = "Alpha",
	event = function()
		-- Only load when no files are opened
		if vim.fn.argc() == 0 then
			return "VimEnter"
		end
	end,
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		-- dashboard.section.header.val = {
		-- 	[[          ▀████▀▄▄              ▄█ ]],
		-- 	[[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
		-- 	[[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
		-- 	[[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
		-- 	[[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
		-- 	[[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
		-- 	[[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
		-- 	[[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
		-- 	[[   █   █  █      ▄▄           ▄▀   ]],
		-- }
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <cr>"),
			dashboard.button("SPC f f", "󰈞  Find files"),
			dashboard.button("SPC f h", "  Recently opened files"),
			dashboard.button("SPC f g", "󰈬  Find word"),
			dashboard.button("q", "󰅚  Quit Neovim", ":qa<cr>"),
			-- TODO: more? edit config, sessions? git?
		}
		require("alpha").setup(dashboard.opts)
	end,
}
