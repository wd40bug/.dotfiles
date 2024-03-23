vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    code_actions = {
      ui_select_fallback = true,
    },
    test_executor = 'background',
  },
  -- LSP configuration
  server = {
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(bufnr, true)

      vim.keymap.set('n', '<leader>a', function()
        vim.cmd.RustLsp('codeAction')
      end, { buffer = bufnr })

      vim.keymap.set('n', '<leader>e', function()
        vim.cmd.RustLsp('explainError')
      end)

      vim.keymap.set('n', '<f5>', function()
        vim.cmd.RustLsp('runnables')
      end, { buffer = bufnr })

      vim.keymap.set('n', '<f6>', function()
        vim.cmd.RustLsp('debuggables')
      end, { buffer = bufnr })


      vim.keymap.set('n', '<f7>', function()
        vim.cmd.RustLsp('testables')
      end, { buffer = bufnr })

      vim.keymap.set('n', '<leader>m', function()
        vim.cmd.RustLsp('expandMacro')
      end, { buffer = bufnr })


      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
