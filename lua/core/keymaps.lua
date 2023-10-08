vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- file explorere
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>E', ':NvimTreeFindFile<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
