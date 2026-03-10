-- https://luals.github.io/wiki/settings/

vim.lsp.config('lua_ls', {
  capabilities = Lsp_capabilities,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        -- REMOVE 'ignoreDir' or set it to an empty table
        ignoreDir = {},
      },
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

vim.lsp.enable('lua_ls')

Luasnip.add_snippets('lua', {
  Luasnip.snippet(
    '---@type', {
      Luasnip.text_node('---@type '),
      Luasnip.insert_node(1, 'type')
    }
  )
})
