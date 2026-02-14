vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- spaces > tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- relative file numbers
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.relativenumber = true

-- display all effects of a substitution in split panel
vim.opt.inccommand = "split"

-- decrease for better perceived lsp performance
vim.opt.updatetime = 500

-- keep cursor centered
vim.opt.scrolloff = 8

-- preview substitutions as you type
vim.opt.inccommand = "split"

-- make jumplist behave like tagstack and maintain cursor position after jumps and <C-o>
vim.opt.jumpoptions = "stack,view"

-- disable scrolling with mouse
vim.opt.mousescroll = "hor:0"

-- signcolumn always on to prevent buffer contents shifting
vim.opt.signcolumn = "yes:1"

-- prevent buffer from moving when creating horizontal splits
vim.opt.splitkeep = "screen"
