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
lazy.opts = {}

lazy.setup({
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'navarasu/onedark.nvim' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {}
  },
  { 'numToStr/Comment.nvim' },
  { 'tpope/vim-surround' },
  { 'akinsho/toggleterm.nvim' },
  { 'lewis6991/gitsigns.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'jiangmiao/auto-pairs' },
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter' }, -- Parses code as AST
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'RRethy/nvim-treesitter-textsubjects' },
  { 'wellle/targets.vim' },
  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  -- Completion for neovim internals
  { 'folke/neodev.nvim' },
  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
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
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  -- Debug
  { 'mfussenegger/nvim-dap' },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }
  },
  { 'theHamsta/nvim-dap-virtual-text' },
})

-- require('vim-fugitive').setup {}

require('onedark').setup {
  style = 'darker'
}

require('lualine').setup {
  options = {
    theme = 'onedark'
    -- ... your lualine config
  }
}

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
  shade_terminals = true
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

require('neodev').setup({
  library = { plugins = { 'nvim-dap-ui' }, types = true },
  lspconfig = false,
})

require('dapui').setup()


