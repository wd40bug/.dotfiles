vim.lsp.config('asm_lsp',{
  capabilities = Lsp_capabilities,
  cmd = { "asm-lsp" },
})

vim.lsp.enable('asm_lsp')
