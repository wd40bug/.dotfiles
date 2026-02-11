vim.lsp.config('ts_ls',{
  cmd = {"typescript-language-server", "--stdio"},
  capabilities = Lsp_capabilities,
})

vim.lsp.enable('ts_ls')
