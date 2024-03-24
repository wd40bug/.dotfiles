require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = 'onedark'
    -- ... your lualine config
  }
}


vim.opt.termguicolors = true
vim.cmd.colorscheme "onedark"
