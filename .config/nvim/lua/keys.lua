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

-- Hop
local hop = require('hop')
local directions = require('hop.hint').HintDirection
local hop_leader = 'h'
vim.keymap.set('', hop_leader .. 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = 'Hop to character (after cursor, current line)' })
vim.keymap.set('', hop_leader .. 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = 'Hop to character (before cursor, current line)' })
vim.keymap.set('', hop_leader .. 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = 'Hop to character before match (after cursor, current line)' })
vim.keymap.set('', hop_leader .. 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = 'Hop to character before match (before cursor, current line)' })
vim.keymap.set('', hop_leader .. hop_leader, function()
  ---@diagnostic disable-next-line
  hop.hint_words({})
end, { remap = true, desc = 'Hop to word' })
vim.keymap.set('', hop_leader .. 'a', function()
  hop.hint_anywhere({ direction = directions.AFTER_CURSOR })
end, { remap = true, desc = 'Hop to anywhere after cursor' })
vim.keymap.set('', hop_leader .. 'A', function()
  hop.hint_anywhere({ direction = directions.BEFORE_CURSOR })
end, { remap = true, desc = 'Hop to anywhere before cursor' })
vim.keymap.set('', hop_leader .. 'l', function()
  hop.hint_lines({ direction = directions.AFTER_CURSOR })
end, { remap = true, desc = 'Hop to any line after cursor' })
vim.keymap.set('', hop_leader .. 'L', function()
  hop.hint_lines({ direction = directions.BEFORE_CURSOR })
end, { remap = true, desc = 'Hop to any line before cursor' })
vim.keymap.set('', hop_leader .. 'p', function()
  vim.cmd(':HopPattern')
end, { remap = true, desc = 'Hop to pattern' })

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
vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ lsp_format = 'fallback' })
end, { desc = 'Format buffer' }) -- Format
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.json' },
  callback = function()
    vim.keymap.set('n', '<leader>f', ":%!jq '.'<CR>", { desc = 'Format JSON', buffer = 0 })
  end
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.py', '*.ipynb' },
  callback = function()
    vim.keymap.set('n', '<leader>f', ':%! black - --quiet <CR>', {
      desc = 'Format Python with Black',
      buffer = 0
    })
  end
})

vim.keymap.set('n', '<leader>/', function()
  vim.cmd(':nohlsearch')
end, { desc = 'Clear previous search' })
