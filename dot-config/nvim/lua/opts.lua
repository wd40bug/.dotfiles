vim.opt.number = true -- Line Numbers
vim.opt.smartcase = true -- Searches case sensitive only when there are multi-case strings
vim.opt.expandtab = true -- Tabs as spaces
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.splitright = true
vim.g.mapleader = ' ' -- Set mapleader to space
vim.g.c_syntax_for_h = true;
vim.opt.filetype = 'on'
vim.cmd("filetype plugin on")
vim.opt.tabstop = 2 -- Makes a tab worth two space
vim.opt.shiftwidth = 2 -- Makes the autoindent every two spaces
vim.o.exrc = false

-- Sandbox 
vim.g.localvimrc_sandbox = 0
vim.g.localvimrc_ask = 1
--persistant undo
local undo_path = vim.fn.expand('~/.vim_undo')
if ( vim.fn.isdirectory(undo_path) == 0) then
  if System == 'windows' then
    os.execute('mkdir '.. undo_path)
  else
    os.execute('mkdir ' .. undo_path .. ' -m 0700')
  end
end
vim.opt.undodir = undo_path
vim.opt.undofile = true
vim.opt.visualbell = true

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h11"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_position_animation_length = 0.05
end

-- Bookmarks
vim.g.startup_bookmarks = require("bookmarks")
