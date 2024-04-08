vim.opt.number = true -- Line Numbers
vim.opt.smartcase = true -- Searches case sensitive only when there are multi-case strings
vim.opt.expandtab = true -- Tabs as spaces
vim.opt.wrap = false -- Don't wrap long lines
vim.g.mapleader = ' ' -- Set mapleader to space

vim.opt.filetype = 'on'
vim.cmd("filetype plugin on")
vim.opt.tabstop = 2 -- Makes a tab worth two space
vim.opt.shiftwidth = 2 -- Makes the autoindent every two spaces

-- vim.api.nvim_create_autocmd({'BufWinEnter', 'BufEnter'}, {
--   pattern = "asm",
--   callback = function () 
--     vim.opt.tabstop = 15 
--     vim.opt.shiftwidth = 15 
--   end,
--   desc="Change tabwidth for assembly files"
-- })
--
-- vim.api.nvim_create_autocmd({"BufWinLeave", "BufLeave"}, {
--   pattern = "*.asm",
--   callback = function ()
--     vim.opt.tabstop = 2
--     vim.opt.tabstop = 2
--   end,
--   desc="Change back tabwidth when leaving asm file"
-- })
