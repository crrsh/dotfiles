-- TODO:
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	enabled = vim.fn.has("nvim-0.7.0") == 1,
	opts = { check_ts = true },
}
