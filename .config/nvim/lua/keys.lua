-- Copy and paste from clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p')
-- Delete without register
vim.keymap.set({ 'n', 'x' }, 'x', '"_x') -- use x to delete character without putting it into register
vim.keymap.set({ 'n', 'x' }, 'X', '"_d') -- use X to delete like with d without putting it into register

-- Select all text in current file
-- vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Telescope
local t_lead = 't' -- Telescope leader
vim.keymap.set('n', t_lead .. '<space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', t_lead .. '?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', t_lead .. 'ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', t_lead .. 'fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', t_lead .. 'd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', t_lead .. 'fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', t_lead .. 'c', '<cmd>Telescope commands<cr>')
vim.keymap.set('n', t_lead .. 'h', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', t_lead .. 's', '<cmd>Telescope lsp_document_symbols<cr>')
vim.keymap.set('n', t_lead .. 'S', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')

--Debug
local d_lead = '<f1>'
local dap = require('dap')
local dapui = require('dapui')

vim.keymap.set('n', d_lead .. 'b', dap.toggle_breakpoint)
vim.keymap.set('n', d_lead .. 'c', dap.continue)
vim.keymap.set('n', d_lead .. 'o', dap.step_over)
vim.keymap.set('n', d_lead .. 'i', dap.step_into)
vim.keymap.set('n', d_lead .. 'r', dap.repl.open)
vim.keymap.set('n', d_lead .. 't', dapui.toggle)

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

-- Other
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format) -- Format
