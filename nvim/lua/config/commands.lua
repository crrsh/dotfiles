vim.api.nvim_create_user_command("TermRename", function()
	if vim.bo.buftype ~= "terminal" then
		return vim.notify("Not a terminal buffer", vim.log.levels.WARN)
	end

	vim.ui.input({
		prompt = "Terminal name: ",
		default = vim.b.term_name,
	}, function(name)
		if name == nil then
			return
		end
		name = vim.trim(name)
		vim.b.term_name = name ~= "" and name or nil
	end)
end, {})
