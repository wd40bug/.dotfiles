vim.opt.number = true -- Line Numbers
vim.opt.smartcase = true -- Searches case sensitive only when there are multi-case strings
vim.opt.tabstop = 2 -- Makes a tab worth two space
vim.opt.shiftwidth = 2 -- Makes the autoindent every two spaces
vim.opt.expandtab = true -- Tabs as spaces
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.splitright = true
vim.g.mapleader = ' ' -- Set mapleader to space

vim.opt.filetype = 'on'
vim.cmd("filetype plugin on")
vim.opt.tabstop = 2 -- Makes a tab worth two space
vim.opt.shiftwidth = 2 -- Makes the autoindent every two spaces
vim.o.exrc = false
vim.g.c_syntax_for_h = true

--persistant undo
local undo_path = vim.fn.expand('~/.vim_undo')
if ( vim.fn.isdirectory(undo_path) == 0) then
  os.execute(string.format('mkdir %s', undo_path))
end
vim.opt.undodir = undo_path
vim.opt.undofile = true
vim.o.visualbell = true

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_position_animation_length = 0.05
end

vim.g.startup_bookmarks = {
  ["N"] = '~/.dotfiles/.config/nvim/',
  ["S"] = '~/Projects/Organicam/software/sw/',
  ["O"] = '~/Projects/Organicam/',
  ["B"] = '~/Projects/Organicam/software/GSE/backend/',
  ["F"] = '~/Projects/Organicam/software/GSE/frontend/',
}
