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
  -- Libraries
  { 'nvim-lua/plenary.nvim' },
  -- Visuals
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'navarasu/onedark.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000
  },
  { 'rebelot/kanagawa.nvim' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      enabled = true,
      scope = {
        enabled = false,
      },
      indent = {
        char = '▏',
      },
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '➤' },
        topdelete = { text = '➤' },
        changedelete = { text = '➤' },
      }
    }
  },
  {
    'startup-nvim/startup.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      require 'startup'.setup({ theme = 'startify' })
    end
  },
  -- Tools
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  { 'tpope/vim-surround' },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = '<C-g>',
      direction = 'horizontal',
      shade_terminals = true,
      shell = 'fish'
    }
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      enable_moveright = false,
    }
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
  },
  { 'wellle/targets.vim' },
  {
    'nvim-telescope/telescope.nvim',
    opts = {
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
    }
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
    'wd40bug/Hints.nvim',
    dev = true
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
    opts = {
      view_options = {
        show_hidden = true
      }
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
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
  {
    'jedrzejboczar/exrc.nvim',
    dependencies = { 'neovim/nvim-lspconfig' }, -- (optional)
    config = true,
    opts = {
      on_dir_changed = {
        enabled = true,
        use_ui_select = false
      }
    },
  },
  { 'echasnovski/mini.nvim',      version = '*' },
  {
    'ahmedkhalf/project.nvim',
    version = '*',
    config = function()
      require('project_nvim').setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.luarc.json', 'Cargo.toml' },
      })
    end
  },
  -- Language support
  {
    'stevearc/conform.nvim',
    opts = {
      format_by_ft = {
        xml = 'xmlformat',
        python = { 'ruff_format' },
        c = { 'clang-format' },
        json = { 'jq' },
      }
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'lazy.nvim',
      },

    },
  },
  {
    'Bilal2453/luvit-meta',
    lazy = true
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
    lazy = false
  },
  {
    'saecki/crates.nvim',
    opts = {},
  },
  { 'p00f/clangd_extensions.nvim' },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    commit = '6610090a4e68d10fd73b68450004dafd26e7cc34',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  { 'henry-hsieh/riscv-asm-vim',                  ft = { 'riscv_asm' } },
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },
  {
    'danymat/neogen',
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },


  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' }, -- Parses code as AST
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-textsubjects' },

  -- LSP
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'zjp-CN/nvim-cmp-lsp-rs',
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' }
  },

  -- Debug
  { 'mfussenegger/nvim-dap' },
  {
    'rcarriga/nvim-dap-ui', opts = {},
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
  },
  { 'theHamsta/nvim-dap-virtual-text' },

})

Hints = require('Hints')
Hints.setup({
  hint_keys = {
    vim.g.mapleader,
    't',
    'T',
    'H',
    '\''
  }
})

require('telescope').load_extension('projects')

vim.g.undotree_DiffCommand = 'FC'
Dap = require('dap')
Dap.set_log_level('TRACE')
