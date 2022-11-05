local api = vim.api
local opts = { noremap = true, silent = true }

api.nvim_set_keymap('i', 'jk', '<Esc>', opts)
api.nvim_set_keymap('i', 'kj', '<Esc>', opts)
api.nvim_set_keymap('t', '<Esc>', '<C-\><C-n>', opts)
api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', opts)
api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', opts)
api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', opts)
api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', opts)

-- telescope for files a buffers
api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)

-- lsp stuff
-- line diagnositc and code action
api.nvim_set_keymap('n', '<leader>d', vim.diagnostic.open_float(), opts)
api.nvim_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action(), opts)

-- diagnostics in current buffer and all buffers
api.nvim_set_keymap('n', '<leader>fd', require('telescope.builtin').diagnostics{ bufnr = 0 }, opts)
api.nvim_set_keymap('n', '<leader>fD', require('telescope.builtin').diagnostics{}, opts)

-- symbols in document or workspace
api.nvim_set_keymap('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols{}, opts)
api.nvim_set_keymap('n', '<leader>fS', require('telescope.builtin').lsp_workspace_symbols{}, opts)

-- references, implementations, and  definitions
api.nvim_set_keymap('n', '<leader>gr', require('telescope.builtin').lsp_references{}, opts)
api.nvim_set_keymap('n', '<leader>gi', require('telescope.builtin').lsp_implementations{}, opts)
api.nvim_set_keymap('n', '<leader>gd', require('telescope.builtin').lsp_definitions{}, opts)

-- pounce
api.nvim_set_keymap('n', 's', '<cmd>Pounce<CR>', opts)
api.nvim_set_keymap('n', 'S', '<cmd>PounceRepeat<CR>', opts)
api.nvim_set_keymap('v', 's', '<cmd>Pounce<CR>', opts)
