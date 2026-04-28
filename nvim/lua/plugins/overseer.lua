local function overseer_action_on_last(action)
	local overseer = require("overseer")
	local task_list = require("overseer.task_list")
	local tasks = overseer.list_tasks({
		sort = task_list.sort_finished_recently,
		include_ephemeral = true,
	})
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], action)
	end
end
return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerToggle", "OverseerRun", "OverseerShell" },
	keys = {
		{ "<leader>oo", "<cmd>OverseerToggle!<cr>", desc = "Overseer toggle" },
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run" },
		{ "<leader>os", "<cmd>OverseerShell<cr>", desc = "Overseer shell" },
		{ "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Overseer task action" },
		{
			"<leader>od",
			function()
				overseer_action_on_last()
			end,
			desc = "Overseer do quick action",
		},
		{
			"<leader>oR",
			function()
				overseer_action_on_last("restart")
			end,
			desc = "Overseer do quick restart",
		},
	},
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {
		task_list = {
			keymaps = {
				-- change keys for scrolling preview since I use the defaults for jumping between windows
				["<C-k>"] = false,
				["<C-j>"] = false,
				["K"] = "keymap.scroll_output_up",
				["J"] = "keymap.scroll_output_down",
				-- quicker actions
				["r"] = { "keymap.run_action", opts = { action = "restart" }, desc = "Restart task" },
				["R"] = { "keymap.run_action", opts = { action = "retain" }, desc = "Retain task" },
				["w"] = { "keymap.run_action", opts = { action = "watch" }, desc = "Watch task" },
				["u"] = { "keymap.run_action", opts = { action = "unwatch" }, desc = "Unwatch task" },
				["e"] = { "keymap.run_action", opts = { action = "ensure" }, desc = "Ensure task" },
			},
			render = function(task)
				local render = require("overseer.render")
				local lines = render.format_standard(task)
				local tags = {}
				if not task:has_component("on_complete_dispose") then
					table.insert(tags, "R")
				end
				if task:has_component("restart_on_save") then
					table.insert(tags, "W")
				end
				if task:has_component("on_complete_restart") then
					table.insert(tags, "E")
				end
				if #tags > 0 then
					table.insert(lines[1], 1, { "[" .. table.concat(tags, "|") .. "] ", "Comment" })
				end
				return lines
			end,
		},
	},
}
