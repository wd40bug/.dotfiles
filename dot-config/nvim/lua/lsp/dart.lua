require('flutter-tools').setup({
  lsp = {
    capabilities = Lsp_capabilities,
    on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      vim.keymap.set('n', '<F5>', function()
        vim.cmd.FlutterRun()
      end, {
        buffer = bufnr, desc = 'Run flutter app'
      })
      local flutter_leader = 'z'
      Hints.add_hint_key('z', bufnr)
      vim.keymap.set('n', flutter_leader .. 'r', function()
        vim.cmd.FlutterReload()
      end, { buffer = bufnr, desc = 'Reload flutter app' })
      vim.keymap.set('n', flutter_leader .. 'R', function()
        vim.cmd.FlutterRestart()
      end, { buffer = bufnr, desc = 'Restart flutter app' })
      vim.keymap.set('n', flutter_leader .. 's', function()
        vim.cmd.FlutterRun()
      end, { buffer = bufnr, desc = 'Run flutter app' })
      vim.keymap.set('n', flutter_leader .. 'q', function()
        vim.cmd.FlutterQuit()
      end, { buffer = bufnr, desc = 'Quit flutter app' })
      vim.keymap.set('n', flutter_leader .. 'o', function()
        vim.cmd.FlutterOutlineToggle()
      end, { buffer = bufnr, desc = 'Toggle flutter outline' })
    end

  }
})
