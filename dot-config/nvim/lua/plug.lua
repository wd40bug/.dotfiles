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


  --  Libraries : ---------------------------------------------------------------------- (section)  --
  { 'nvim-lua/plenary.nvim' },
  --  (section) ---------------------------------------------------------------------- : Libraries  --

  --  Visuals : ------------------------------------------------------------------------ (section)  --
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
  {
    'HiPhish/rainbow-delimiters.nvim'
  },

  --  (section) ------------------------------------------------------------------------ : Visuals  --


  --  General Tools : ------------------------------------------------------------------ (section)  --
  {
    'YUSHACOD/sections.nvim',
    config = function()
      require('sections').setup({
        -- all options are optional; these are the defaults
        marker = '(section)',
        width = 100,
        keymaps = {
          next = ']s',
          prev = '[s',
          ['end'] = '<leader>es',
          create = '<leader>sc',
          jump = '<leader>sj',
          delete = '<leader>sd',
          telescope = '<leader>ss',
        },
        textobjects = true,
        commands = true,
        wrap_navigation = false,
      })
    end,
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = '<C-g>',
      direction = 'horizontal',
      shade_terminals = true,
      shading_factor = System == 'termux' and 1 or nil,
      shell = (System == 'termux' or System == 'ubuntu') and 'fish' or 'pwsh'
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
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    lazy = false,
    opts = {},
  },
  { 'numToStr/Comment.nvim', opts = {} },

  { 'tpope/vim-surround' },

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
    'jedrzejboczar/exrc.nvim',
    dependencies = { 'neovim/nvim-lspconfig' }, -- (optional)
    config = true,
    opts = {
      on_dir_changed = {
        enabled = true,
        use_ui_select = false
      },
      trust_on_write = true,
      use_telescope = true,
      lsp = {
        auto_setup = true,
      }
    },
  },
  { 'echasnovski/mini.nvim',      version = '*' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' }
  },
  {
    'HakonHarnes/img-clip.nvim',
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  },

  --  (section) ------------------------------------------------------------------ : General Tools  --

  --  Language Support : --------------------------------------------------------------- (section)  --
  System == 'termux' and {
    'mason-org/mason.nvim',
    opts = { PATH = 'append' }
  } or {},
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        xml = { 'xmlformat' },
        python = { 'ruff_format' },
        c = { 'clang-format' },
        json = { 'jq' },
      }
    },
  },
  {
    'folke/lazydev.nvim',
    -- ft = 'lua', -- only load on lua files
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
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xb',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
    },
  },

  --  (section) --------------------------------------------------------------- : Language Support  --

  --  AI : ----------------------------------------------------------------------------- (section)  --
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        -- Your configuration options here
        cmp = {
          enable_auto_complete = true,
        },
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-c>',
            dismiss = '<A-e>',
          },
        },
        provider = 'openai_fim_compatible',
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:3b',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
      }
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      interactions = {
        chat = {
          adapter = 'ollama',
          model = 'deepseek-coder-v2:lite'
        },
        inline = {
          adapter = 'ollama',
          model = 'starcoder2:7b'
        },
        cmd = {
          adapter = 'ollama',
          model = 'starcoder2:7b'
        },
        background = {
          adapter = {
            name = 'ollama',
            model = 'qwen2.5-coder:7b',
          },
        },
      },
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = 'DEBUG', -- or "TRACE"
      },
    },
  },
  --  (section) ----------------------------------------------------------------------------- : AI  --

  --  TreeSitter : --------------------------------------------------------------------- (section)  --

  { 'nvim-treesitter/nvim-treesitter' }, -- Parses code as AST
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-textsubjects' },
  --  (section) --------------------------------------------------------------------- : TreeSitter  --


  --  LSP : ---------------------------------------------------------------------------- (section)  --
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
      opts.sources.per_filetype = {
        codecompanion = { 'codecompanion' },
      }
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

  --  (section) ---------------------------------------------------------------------------- : LSP  --

  --  Debugging : ---------------------------------------------------------------------- (section)  --
  { 'mfussenegger/nvim-dap' },
  {
    'rcarriga/nvim-dap-ui',
    -- opts = {},
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
  },
  { 'theHamsta/nvim-dap-virtual-text' },

  --  (section) ---------------------------------------------------------------------- : Debugging  --

})

Hints = require('Hints')
Hints.setup({
  hint_keys = {
    vim.g.mapleader,
  }
})

vim.g.undotree_DiffCommand = 'FC'

require('dapui').setup()
Dap = require('dap')
Dap.set_log_level('TRACE')

require('mini.diff').setup({

})
