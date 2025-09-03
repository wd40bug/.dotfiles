vim.bo.expandtab = true
vim.bo.tabstop = 15
vim.bo.shiftwidth = 15

vim.b.undo_ftplugin = function ()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
end

