
Lspconfig.lua_ls.setup({
  capabilities = Lsp_capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          quote_style = 'single'
        }
      },
      completion = {
        enable = true,
        callSnippet = 'Both'
        
      }
    } 
  }
})
