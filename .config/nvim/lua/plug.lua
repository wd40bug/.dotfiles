local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {
  dev = {
    path = '~/coding/lua_plugins/',
    patters = { 'wd40bug' },
    fallback = true,
  }
}

lazy.setup({
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'navarasu/onedark.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {}
  },
  { 'numToStr/Comment.nvim' },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  { 'tpope/vim-surround' },
  { 'akinsho/toggleterm.nvim' },
  { 'lewis6991/gitsigns.nvim' },
  { 'nvim-lua/plenary.nvim' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      enable_moveright = false,
    }
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'stevearc/conform.nvim',
    opts = {
      format_by_ft = {
        xml = 'xmlformat',
      }
    },
  },
  {
    'mistricky/codesnap.nvim', build = 'make'
  },
  {
    'AlejandroSuero/freeze-code.nvim',
    opts = {
      copy = true,
      open = true,
      freeze_config = {
        background = '#535c68',
        show_line_numbers = true,
        font = {
          family = 'JetBrainsMono Nerd Font Mono',
          ligatures = 'true',
        },
        theme = 'onedark',
        border = {
          radius = 8
        },
        window = true,

      }
    },
  },                                     -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' }, -- Parses code as AST
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-textsubjects' },
  { 'wellle/targets.vim' },
  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  -- Completion for neovim internals
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        'lazy.nvim',
      },

    },
  },
  {
    'Bilal2453/luvit-meta',
    lazy = true
  }, -- optional `vim.uv` typings
  -- LSP
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'zjp-CN/nvim-cmp-lsp-rs',
      opts = {

      }
    }
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = { 'rust' },
  },
  {
    'saecki/crates.nvim',
    opts = {},
  },
  { 'p00f/clangd_extensions.nvim' },
  -- Debug
  { 'mfussenegger/nvim-dap' },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
  },
  { 'theHamsta/nvim-dap-virtual-text' },

  --KeyHints
  {
    'wd40bug/Hints.nvim',
    dev = true
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    }
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    }
  },
  {
    'mbbill/undotree'
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    commit = '6610090a4e68d10fd73b68450004dafd26e7cc34',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  { 'henry-hsieh/riscv-asm-vim',      ft = { 'riscv_asm' } },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  },

  { 'normen/vim-pio' },
  { 'embear/vim-localvimrc'},
})

Hints = require('Hints')
Hints.setup({
  hint_keys = {
    vim.g.mapleader,
    't',
    '<F1>',
    'h',
    'z'
  }
})

require('ibl').setup({
  enabled = true,
  scope = {
    enabled = false,
  },
  indent = {
    char = '▏',
  },
})

---@diagnostic disable-next-line: missing-fields
require('Comment').setup({})

require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true,
  shell = 'fish'
})

require('gitsigns').setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '➤' },
    topdelete = { text = '➤' },
    changedelete = { text = '➤' },
  }
})

require('codesnap').setup({
  save_path = '~/Coding/Snaps/',
  has_breadcrumbs = true,
  bg_color = '#535c68',
  watermark = '',
  code_font_family = 'JetBrainsMono Nerd Font Mono',
})


require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      'target',
      -- 'android', --dart
      -- 'build',
      -- 'ios',
      -- 'macos',
      -- 'linux',
      -- 'windows',
      -- 'web'
    }
  }
})
