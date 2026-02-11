vim.lsp.config('pyright',{
  capabilities = Lsp_capabilities,
  settings = {
    python = {
      venvPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV or vim.env.PYENV_ROOT,
    }
  }
})

vim.lsp.enable('pyright')
