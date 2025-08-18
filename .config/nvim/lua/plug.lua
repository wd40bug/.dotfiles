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

  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {
  dev = {
    path = '~/coding/lua_plugins/',
    patterns = { 'wd40bug' },
    fallback = true,
  }
}

lazy.setup({
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
  {
    'danymat/neogen',
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
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
      formatters_by_ft = {
        xml = { 'xmlformat' },
        python = { 'ruff_format' },
        c = { 'clang-format' },
        json = { 'jq' }
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
      },
    },
  },
  {
    'p00f/clangd_extensions.nvim'
  },
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter',            build = ':TSUpdate' }, -- Parses code as AST
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-textsubjects' },
  { 'wellle/targets.vim' },
  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  -- Completion for neovim internals
  -- LSP
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'zjp-CN/nvim-cmp-lsp-rs',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end
    }
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp',        commit = '99c4e3e' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'saecki/crates.nvim',
    opts = {},
  },
  { 'p00f/clangd_extensions.nvim' },
  -- Debug
  { 'epheien/termdbg', dev = true },
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
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      }
    },
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
    'startup-nvim/startup.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      require 'startup'.setup({ theme = 'startify' })
    end
  },
  { 'echasnovski/mini.nvim', version = '*' },
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
  }
})

Hints = require('Hints')
Hints.setup({
  hint_keys = {
    vim.g.mapleader,
    't',
    'T',
    '\'',
    'H',
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

require('Comment').setup({})

require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true,
  shell = 'pwsh'
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

require('dapui').setup()

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

require('telescope').load_extension('projects')

vim.g.undotree_DiffCommand = 'FC'
Dap = require('dap')
