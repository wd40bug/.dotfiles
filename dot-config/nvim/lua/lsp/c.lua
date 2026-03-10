vim.lsp.config('clangd',{
  capabilities = Lsp_capabilities,
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.keymap.set('n', '<leader>h', function()
      vim.cmd.ClangdSwitchSourceHeader()
    end, { buffer = bufnr, desc = 'Switch to header file' })
    vim.keymap.set('n', '<leader>i', function()
      vim.cmd.ClangdTypeHierarchy()
    end, { buffer = bufnr, desc = 'Class Type Hierarchy' })
  end,
  cmd = {
    'clangd',
    '--query-driver=~/Downloads/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc,/home/wd40bug/.platformio/packages/toolchain-xtensa-esp32*/bin/xtensa-esp32-elf-g++',
  }
})

vim.lsp.enable('clangd')

Dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}

Dap.configurations.c = {
  {
    name = 'Run Executable',
    type = 'gdb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = true,
  },
  {
    name = 'Select and attach to process',
    type = 'gdb',
    request = 'attach',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pid = function()
      local name = vim.fn.input('Executable name (filter): ')
      return require('dap.utils').pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}'
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'gdb',
    request = 'attach',
    target = 'localhost:1234',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}'
  },
}

