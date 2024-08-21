-- Copy and paste from clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
-- Delete without register
vim.keymap.set({ 'n', 'x' }, 'x', '"_x') -- use x to delete character without putting it into register
vim.keymap.set({ 'n', 'x' }, 'X', '"_d') -- use X to delete like with d without putting it into register

-- Select all text in current file
-- vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Telescope
local t_lead = 't' -- Telescope leader
vim.keymap.set('n', t_lead .. '<leader>', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', t_lead .. 'o', '<cmd>Telescope oldfiles<cr>', { desc = 'Old files' })
vim.keymap.set('n', t_lead .. 'ff', '<cmd>Telescope find_files follow=true<cr>', { desc = 'File finder' })
vim.keymap.set('n', t_lead .. 'fg', '<cmd>Telescope live_grep<cr>', { desc = 'Grep files' })
vim.keymap.set('n', t_lead .. 'd', '<cmd>Telescope diagnostics<cr>', { desc = 'Diagnostics' })
vim.keymap.set('n', t_lead .. 'fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Fuzzy finder' })
vim.keymap.set('n', t_lead .. 'c', '<cmd>Telescope commands<cr>', { desc = 'Telescope commands' })
vim.keymap.set('n', t_lead .. 'h', '<cmd>Telescope help_tags<cr>', { desc = 'Help' })
vim.keymap.set('n', t_lead .. 's', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Symbols document' })
vim.keymap.set('n', t_lead .. 'S', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = 'Symbols workspace' })

--Debug
local d_lead = '<f1>'
local dap = require('dap')
local dapui = require('dapui')

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

-- Other
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer' }) -- Format
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.json' },
  callback = function()
    vim.keymap.set('n', '<leader>f', ":%!jq '.'<CR>", { desc = 'Format JSON', buffer = 0 })
  end
})

vim.keymap.set('n', '<leader>/', function()
  vim.cmd(':nohlsearch')
end, { desc = 'Clear previous search' })
