local opt = vim.opt

-- vim.g.mapleader = ' '
opt.termguicolors = true
opt.completeopt = 'menuone,noinsert,noselect'
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.signcolumn = 'yes'
opt.shortmess:append('c')
opt.updatetime = 300
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.cursorline = true
-- vim.cmd('syntax enable')
-- vim.cmd('filetype plugin indent on')

-- require('kanagawa').setup{
--     colors = {
--         theme = {
--             all = {
--                 ui = {
--                     bg_gutter = 'none',
--                 }
--             }
--         }
--     }
-- }
-- 
-- vim.cmd('colorscheme kanagawa')

-- clear Todo highlight (no weird highlighting in markdown todo lists)
vim.api.nvim_set_hl(0, 'Todo', {})
