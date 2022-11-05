local opt = vim.opt

vim.g.mapleader = ' '
opt.termguicolors = true
opt.completeopt = 'menuone,noinsert,noselect'
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.autoindent = true
opt.tapstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.singcolumn = 'yes'
opt.shortmess:append('c')
opt.updatetime = 300
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.cursorline = true
vim.cmd [[colorscheme kanagawa]]
vim.cmd [[syntax enable]]
vim.cmd [[filetype plugin indent on]]
