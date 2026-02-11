vim.lsp.config('html',{
  capabilities = Lsp_capabilities,
  cmd = { 'html-languageserver', '--stdio' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
  settings = {}
})

vim.lsp.enable('html')
