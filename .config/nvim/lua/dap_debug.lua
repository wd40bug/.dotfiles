--Debug
local d_lead = '<f6>'
local dap = require('dap')
local dapui = require('dapui')
dapui.setup({})
dap.set_log_level('TRACE')

vim.keymap.set('n', d_lead .. 'b', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', d_lead .. 'c', dap.continue, { desc = 'Continue' })
vim.keymap.set('n', d_lead .. 'o', dap.step_over, { desc = 'Step over' })
vim.keymap.set('n', d_lead .. 'i', dap.step_into, { desc = 'Step into' })
vim.keymap.set('n', d_lead .. 'r', dap.repl.open, { desc = 'Open repl' })
vim.keymap.set('n', d_lead .. 't', dapui.toggle, { desc = 'Toggle dapui' })

-- Auto open and close
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/wd40bug/Downloads/ms-vscode.cpptools-1.22.11-linux-x64/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.asm = {
  {
    name = 'Launch file',
    type = 'cppdbg',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },

  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },

  },
}
