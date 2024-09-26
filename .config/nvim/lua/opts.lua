vim.opt.number = true -- Line Numbers
vim.opt.smartcase = true -- Searches case sensitive only when there are multi-case strings
vim.opt.expandtab = true -- Tabs as spaces
vim.opt.wrap = false -- Don't wrap long lines
vim.g.mapleader = ' ' -- Set mapleader to space

vim.opt.filetype = 'on'
vim.cmd("filetype plugin on")
vim.opt.tabstop = 2 -- Makes a tab worth two space
vim.opt.shiftwidth = 2 -- Makes the autoindent every two spaces

--persistant undo
local undo_path = vim.fn.expand('~/.vim_undo')
if ( vim.fn.isdirectory(undo_path) == 0) then
  os.execute(string.format('mkdir %s -m 0700', undo_path))
end
vim.opt.undodir = undo_path
vim.opt.undofile = true


