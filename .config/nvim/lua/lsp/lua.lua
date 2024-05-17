
-- https://luals.github.io/wiki/settings/

Lspconfig.lua_ls.setup({
  capabilities = Lsp_capabilities,
  before_init=require("neodev.lsp").before_init,
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
        callSnippet = 'Replace'
        
      }
    } 
  }
})

Luasnip.add_snippets("lua", {
  Luasnip.snippet(
    "---@type",{
      Luasnip.text_node("---@type "),
      Luasnip.insert_node(1, "type")
    }
  )
})
