require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = 'light'
    -- ... your lualine config
  }
}

vim.opt.termguicolors = true
vim.cmd.colorscheme "onedark"
