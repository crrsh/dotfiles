vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- add "CursorHold" to be more aggressive
  desc = "Keep buffer contents updated",
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})
