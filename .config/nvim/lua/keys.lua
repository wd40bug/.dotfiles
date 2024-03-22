-- Copy and paste from clipboard
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p')
-- Delete without register
vim.keymap.set({'n', 'x'}, 'x', '"_x') -- use x to delete character without putting it into register
vim.keymap.set({'n', 'x'}, 'X', '"_d') -- use X to delete like with d without putting it into register 

-- Select all text in current file
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Telescope
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>Telescope commands<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', 'gs', '<cmd>Telescope lsp-document-symbols<cr>')


