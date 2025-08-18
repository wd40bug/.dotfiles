Lspconfig.gopls.setup({
  capabilities = Lsp_capabilities
})

Dap.adapters.go = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.expand('~/Downloads/vscode-go/extension/dist/debugAdapter.js') },
}
Dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    showLog = false,
    program = '${fileDirname}',
    dlvToolPath = vim.fn.exepath('dlv'), -- Adjust to where delve is installed
    args = function()
      local args = vim.fn.input('Arguments')
      return vim.fn.split(args, ' ')
    end,
    console = "integratedTerminal"
  },
}
