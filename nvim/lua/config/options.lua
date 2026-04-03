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
vim.opt.relativenumber = true
vim.opt.number = true

-- enable cursorline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- disable line wrapping so long lines extend off-screen
vim.opt.wrap = false

-- don't create swap files
vim.opt.swapfile = false

-- persist undo history across sessions
vim.opt.undofile = true

-- display all effects of a substitution in split panel
vim.opt.inccommand = "split"

-- decrease for better perceived performance
vim.opt.updatetime = 1000

-- keep cursor centered
vim.opt.scrolloff = 8

-- make jumplist behave like a stack (like tagstack) and restore cursor position on <C-o>
vim.opt.jumpoptions = "stack,view"

-- disable horizontal mouse scrolling
vim.opt.mousescroll = "hor:0"

-- signcolumn always on to prevent buffer contents shifting
vim.opt.signcolumn = "yes:1"

-- keep buffer contents in the same position when opening horizontal splits
vim.opt.splitkeep = "screen"

-- hide the command line when not in use
vim.opt.cmdheight = 0
