vim.lsp.config('fish_lsp',{
  capabilities = Lsp_capabilities,
  command= "fish-lsp",
  filetypes = {
    "fish"
  },
  args = {"start"}
})

vim.lsp.enable('fish_lsp')
