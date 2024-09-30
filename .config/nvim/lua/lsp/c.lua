Lspconfig.clangd.setup({
  capabilities = Lsp_capabilities,
  on_attach = function (client, bufnr)
    vim.lsp.inlay_hint.enable(bufnr, true)
    vim.keymap.set('n', '<leader>h', function ()
      vim.cmd.ClangdSwitchSourceHeader()
    end, {buffer=bufnr, desc="Switch to header file"})
    vim.keymap.set('n', '<leader>i', function ()
      vim.cmd.ClangdTypeHierarchy()
    end, {buffer=bufnr})
  end
})
