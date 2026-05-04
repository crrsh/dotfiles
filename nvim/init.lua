-- NOTE: will be enabled by default in 0.13
require("vim._core.ui2").enable({}) -- TODO: config?

require("config.options")

require("config.lazy")

require("config.keymaps")
require("config.autocmds")

require("config.termedit")

vim.cmd.colorscheme("catppuccin-nvim")
