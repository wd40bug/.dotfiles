-- require('onedark').setup {
--   style = 'darker'
-- }

require('lualine').setup {
  options = {
    theme = 'auto'
    -- ... your lualine config
  }
}

vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin-latte"
