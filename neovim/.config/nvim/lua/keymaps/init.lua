local opts = { noremap = true, silent = true }

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
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- lsp stuff
-- line diagnositc and code action
vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)

-- diagnostics in current buffer and all buffers
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', opts)

-- symbols in document or workspace
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
vim.keymap.set('n', '<leader>fS', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)

-- references, implementations, and  definitions
vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', opts)
vim.keymap.set('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', opts)

-- easyread
vim.keymap.set('n', '<leader>er', '<cmd>EasyreadToggle<CR>', opts)

-- markdown todo toggle
vim.keymap.set('n', '<leader>tt', '<cmd>MkdnToggleToDo<CR>')
