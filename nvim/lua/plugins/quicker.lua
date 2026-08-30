return {
	"stevearc/quicker.nvim",
	ft = "qf",
	---@module "quicker"
	---@type quicker.SetupOptions
	opts = {
    -- stylua: ignore
		keys = {
			{ ">", function() require("quicker").expand() end, desc = "Expand quickfix context" },
			{ "<", function() require("quicker").collapse() end, desc = "Collapse quickfix context" },
		},
		constrain_cursor = false,
	},
}
