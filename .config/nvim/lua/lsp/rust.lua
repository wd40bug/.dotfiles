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
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

      vim.keymap.set('n', '<leader>a', function()
        vim.cmd.RustLsp('codeAction')
      end, { buffer = bufnr, desc = 'Code action' })

      vim.keymap.set('n', '<leader>e', function()
        vim.cmd.RustLsp('explainError')
      end, { buffer = bufnr, desc = 'Explain error' })

      vim.keymap.set('n', '<f5>', function()
        vim.cmd.RustLsp('runnables')
      end, { buffer = bufnr, desc = 'Run' })

      vim.keymap.set('n', '<f6>', function()
        vim.cmd.RustLsp('debuggables')
      end, { buffer = bufnr, desc = 'Debug' })


      vim.keymap.set('n', '<f7>', function()
        vim.cmd.RustLsp('testables')
      end, { buffer = bufnr, desc = 'Test' })

      vim.keymap.set('n', '<leader>m', function()
        vim.cmd.RustLsp('expandMacro')
      end, { buffer = bufnr, desc = 'Expand macro' })

      vim.keymap.set('n', '<leader>h', function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
      end, { buffer = bufnr, desc = 'Hover actions' })

      vim.keymap.set('n', '<leader>u', function()
        vim.cmd.RustLsp({ 'moveItem', 'up' })
      end, { buffer = bufnr, desc = 'Move item up' })

      vim.keymap.set('n', '<leader>d', function()
        vim.cmd.RustLsp({ 'moveItem', 'down' })
      end, { buffer = bufnr, desc = 'Move item down' })

      vim.keymap.set('n', '<leader>d', function()
        vim.cmd.RustLsp({ 'renderDiagnostic', 'current' })
      end, { buffer = bufnr, desc = 'Render diagnostic' })

      vim.keymap.set('n', '<leader>e', function()
        vim.cmd.RustLsp({ 'explainError', 'current' })
      end, { buffer = bufnr, desc = 'Explain error' })

      vim.keymap.set('n', '<leader>c', function()
        vim.cmd.RustLsp({ 'openCargo' })
      end, { buffer = bufnr, desc = 'Open Cargo.toml' })

      vim.keymap.set('n', '<leader>D', function()
        vim.cmd.RustLsp({ 'openDocs' })
      end, { buffer = bufnr, desc = 'Open Docs.rs' })

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

vim.g.rust_recommended_style = false
