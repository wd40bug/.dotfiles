require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = 'auto'
    -- ... your lualine config
  }
}

require('kanagawa').setup({
  overrides = function(colors)
    local theme = colors.theme;
    return {
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
    }
  end,
  commentStyle = { italic = false },
  keywordStyle = { italic = false },
})

vim.opt.termguicolors = true
vim.cmd.colorscheme(System == 'termux' and 'kanagawa-lotus' or 'onedark')
