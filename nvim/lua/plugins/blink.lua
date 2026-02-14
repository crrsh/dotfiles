-- Lifted from https://github.com/hrsh7th/nvim-cmp/blob/v0.0.2/lua/cmp/config/context.lua
-- local function in_treesitter_capture(capture)
-- 	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	if vim.api.nvim_get_mode().mode == "i" then
-- 		col = col - 1
-- 	end
--
-- 	local buf = vim.api.nvim_get_current_buf()
-- 	local get_captures_at_pos = require("vim.treesitter").get_captures_at_pos
--
-- 	local captures_at_cursor = vim.tbl_map(function(x)
-- 		return x.capture
-- 	end, get_captures_at_pos(buf, row - 1, col))
--
-- 	if vim.tbl_isempty(captures_at_cursor) then
-- 		return false
-- 	elseif type(capture) == "string" and vim.tbl_contains(captures_at_cursor, capture) then
-- 		return true
-- 	elseif type(capture) == "table" then
-- 		for _, v in ipairs(capture) do
-- 			if vim.tbl_contains(captures_at_cursor, v) then
-- 				return true
-- 			end
-- 		end
-- 	end
-- 	return false
-- end

return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			min_keyword_length = 1,
			default = { "lsp", "path", "snippets" },
		},
		completion = {
			trigger = { show_on_keyword = false },
			menu = {
				auto_show = true,
				-- auto_show = function()
				-- 	return not in_treesitter_capture({
				-- 		"comment",
				-- 		"string",
				-- 		"variable.parameter",
				-- 	})
				-- end,
				max_height = 10, -- 10 is default
				draw = { treesitter = { "lsp" } },
			},
			ghost_text = {
				enabled = false,
			},
		},
		signature = {
			enabled = true,
			trigger = { enabled = false },
			window = {
				show_documentation = false, -- hover instead
				direction_priority = { "n" }, -- keep it out of the way of completion menu
			},
		},
		keymap = {
			preset = "default",
			["<C-space>"] = { "show_documentation", "hide_documentation" },
			["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },
		},
		opts_extend = { "sources.default" },
	},
}
