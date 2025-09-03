Lspconfig.fish_lsp.setup({
  capabilities = Lsp_capabilities,
  command= "fish-lsp",
  filetypes = {
    "fish"
  },
  args = {"start"}
})
