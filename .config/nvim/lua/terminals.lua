local Terminal        = require('toggleterm.terminal').Terminal
local msys_uctrt64    = Terminal:new({
  cmd = 'C:/msys64/msys2_shell.cmd -defterm -here -no-start -ucrt64',
  count = 2,
  display_name =
  'UCTRT64 / MSYS'
})
local msys_msys       = Terminal:new({
  cmd = 'C:/msys64/msys2_shell.cmd -defterm -here -no-start -msys',
  count = 3,
  display_name =
  'MSYS / MSYS'
})

local tt              = require('toggleterm')

local terminal_leader = 'T'
vim.keymap.set('n', terminal_leader .. 's', ':TermSelect<cr>', { desc = 'Open terminal select' })

vim.keymap.set('n', terminal_leader .. '1', ':ToggleTerm 1<cr>', { desc = 'Open terminal 1 (default)' })

vim.keymap.set('n', terminal_leader .. '2', function()
  msys_uctrt64:toggle()
end, { desc = 'Open terminal 2 (uctrt64)' })

vim.keymap.set('n', terminal_leader .. '3', function()
  msys_msys:toggle()
end, { desc = 'Open terminal 3 (msys)' })
