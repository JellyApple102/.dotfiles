local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

vim.keymap.set('i', 'jk', '<Esc>', opts)
vim.keymap.set('i', 'kj', '<Esc>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', opts)
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', opts)
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', opts)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', opts)
vim.keymap.set('n', 'H', '<cmd>bp<CR>', opts)
vim.keymap.set('n', 'L', '<cmd>bn<CR>', opts)

-- telescope for files a buffers
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
vim.keymap.set('n', '<leader>fh', function() builtin.help_tags{} end, opts)

-- lsp stuff
-- line diagnositc and code action
vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)

-- diagnostics in current buffer and all buffers
vim.keymap.set('n', '<leader>fd', function() builtin.diagnostics{ bufnr = 0 } end, opts)
vim.keymap.set('n', '<leader>fD', function() builtin.diagnostics{} end, opts)

-- symbols in document or workspace
vim.keymap.set('n', '<leader>fs', function() builtin.lsp_document_symbols{} end, opts)
vim.keymap.set('n', '<leader>fS', function() builtin.lsp_workspace_symbols{} end, opts)

-- references, implementations, and  definitions
vim.keymap.set('n', '<leader>gr', function() builtin.lsp_references{} end, opts)
vim.keymap.set('n', '<leader>gi', function() builtin.lsp_implementations{} end, opts)
vim.keymap.set('n', '<leader>gd', function() builtin.lsp_definitions{} end, opts)

-- pounce
vim.keymap.set('n', 's', '<cmd>Pounce<CR>', opts)
vim.keymap.set('n', 'S', '<cmd>PounceRepeat<CR>', opts)
vim.keymap.set('v', 's', '<cmd>Pounce<CR>', opts)

-- easyread
vim.keymap.set('n', '<leader>er', '<cmd>EasyreadToggle<CR>', opts)

-- flote open and markdown todo toggle
vim.keymap.set('n', '<leader>on', '<cmd>Flote<CR>', opts)
vim.keymap.set('n', '<leader>tt', '<cmd>MkdnToggleToDo<CR>')
