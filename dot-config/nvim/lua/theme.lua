require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = 'auto'
    -- ... your lualine config
  },
  sections = {
    lualine_x = {
      {
        require 'minuet.lualine',
        -- the follwing is the default configuration
        -- the name displayed in the lualine. Set to "provider", "model" or "both"
        display_name = 'both',
        -- separator between provider and model name for option "both"
        provider_model_separator = ':',
        -- whether show display_name when no completion requests are active
        display_on_idle = false,
      },
      'encoding',
      'fileformat',
      'filetype',
    },
  },
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
