require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = System == 'termux' and 'auto' or 'onedark'
    -- ... your lualine config
  }
}

require("kanagawa").setup({
  overrides = function (colors)
    local theme = colors.theme;
    return {
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
    }
  end
})

vim.opt.termguicolors = true
vim.cmd.colorscheme (System == 'termux' and 'kanagawa-lotus' or "onedark")
