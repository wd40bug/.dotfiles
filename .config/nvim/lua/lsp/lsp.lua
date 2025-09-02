-- Mason.nvim
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'lua_ls', 'rust_analyzer', 'pyright' },
}

-- Config variables
Lspconfig = require('lspconfig')
Lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local cmp_lsp_rs = require('cmp_lsp_rs')
local comparators_rs = cmp_lsp_rs.comparators
Luasnip = require('luasnip')
local select_opts = { behavior = cmp.SelectBehavior.Select }


vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true, --always show window when diagnostics are available
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»'
    },
    linehl = {
      -- [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.ERROR] = '',
      -- [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.WARN] = '',
      -- [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.HINT] = '',
      -- [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo'
      [vim.diagnostic.severity.INFO] = '',
    }
  }
})


vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

cmp.setup({
  snippet = {
    expand = function(args)
      Luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'path',     keyword_length = 3 },
    { name = 'nvim_lsp', keyword_length = 2 },
    { name = 'buffer',   keyword_length = 5 },
    { name = 'luasnip',  keyword_length = 2 },
    { name = 'lazydev', group_index = 0}
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {

    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    -- Scroll up and down documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    -- Abort completion
    ['<C-e>'] = cmp.mapping.abort(),
    --Completion selection
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    --Functions for luasnip snippets
    --
    ['<C-f>'] = cmp.mapping(
      function(fallback)
        if Luasnip.jumpable(1) then
          Luasnip.jump(1)
        else
          fallback()
        end
      end,
      { 'i', 's' }),

    ['<C-b>'] = cmp.mapping(
      function(fallback)
        if Luasnip.jumpable(-1) then
          Luasnip.jump(-1)
        else
          fallback()
        end
      end,
      { 'i', 's' }),

    ['<Tab>'] = cmp.mapping(
      function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
          cmp.select_next_item(select_opts)
        else
          fallback()
        end
      end,
      { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end,
      { 'i', 's' }),
  },
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.scopes,
      comparators_rs.inscope_inherent_import,
      comparators_rs.sort_by_label_but_underscore_last,
      require('clangd_extensions.cmp_scores'),
      cmp.config.compare.offset,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
    },
    priority_weight = 2.0
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    -- Default LSP config keybinds
    pcall(function() vim.keymap.del('n', 'grr') end) -- Wow that was shockingly easy
    pcall(function() vim.keymap.del('n', 'gra') end)
    pcall(function() vim.keymap.del('n', 'grn') end)
    ---@param mode string
    ---@param lhs string
    ---@param rhs string | function
    ---@param desc string
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = true, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'List implementations')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'List references')

    -- Displays a function's signature information
    bufmap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Show function signature')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')

    -- Show diagnostics in a floating window
    bufmap('n', '<leader>l', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Diagnostic')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Go to prev. diagnostic')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Go to next diagnostic')

    Hints.add_hint_key('g', true)
    Hints.add_hint_key('[', true)
    Hints.add_hint_key(']', true)
  end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.rs', '*.cpp', '*.c', '*.ts', '*.js', '*.dart' },
  callback = function()
    vim.keymap.set('n', ';', function()
      local cursor = vim.api.nvim_win_get_cursor(0);
      vim.cmd('norm! $a;')
      vim.api.nvim_win_set_cursor(0, cursor)
    end, {})
  end
})
-- LSP setups
require('lsp.rust')
require('lsp.lua')
require('lsp.python')
require('lsp.c')
require('lsp.html')
require('lsp.typescript')
require('lsp.fish')
require('lsp.java')
require('lsp.svelte')
require('lsp.arduino')
require('lsp.kotlin')
require('lsp.dart')
require('lsp.asm')
require('lsp.verilog')
