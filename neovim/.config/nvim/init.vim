" plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'rebelot/kanagawa.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'aca/emmet-ls'
Plug 'rlane/pounce.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'akinsho/toggleterm.nvim'

call plug#end()

set termguicolors
colorscheme kanagawa

" telescope
lua << EOF
require('telescope').setup {
    extensions = {
        ["ui-select"] = {
            require('telescope.themes').get_dropdown{}
        }
    }
}

require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')
EOF

" lualine
lua << EOF
require('lualine').setup {
    options = {
        theme = 'kanagawa'
    },
    tabline = {},
}
EOF

" treesitter
lua << EOF
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

require('treesitter-context').setup{}
EOF

" LSP general
lua << EOF
require('lspconfig').jedi_language_server.setup{}

require('lspconfig').tsserver.setup{}
EOF

" ccls
lua << EOF
local lspconfig = require'lspconfig'
local util = lspconfig.util
lspconfig.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        clang = {
            excludeArgs = { "-frounding-math" };
        };
    },
}
EOF

" configure rust-analyzer through rust-tools
lua << EOF
local nvim_lsp = require'lspconfig'
local opts = {
    tools = {
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
}
require('rust-tools').setup(opts) -- opts
EOF

" emmet-ls
lua << EOF
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    }
})
EOF

" set lsp diagnostic symbols
lua << EOF
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " ", }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" completion
set completeopt=menuone,noinsert,noselect

lua << EOF
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require'luasnip'
local cmp = require'cmp'
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  view = {
    entries = { name = "custom", selection_order = "near_cursor" }
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item(select_opts)
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(select_opts)
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp', max_item_count = 7 },
    { name = 'luasnip', max_item_count = 7 },
    { name = 'path', max_item_count = 7 },
    -- { name = 'buffer', max_item_count = 7 },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        path = "[Path]",
      })
    }),
  }
}
EOF

" nvim-autopairs
lua << EOF
require('nvim-autopairs').setup{}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

npairs.add_rules {
  -- space padding rules
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '{}', '[]', '<>' }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ '(  )', '{  }', '[  ]', '<  >' }, context)
    end),
  Rule('', ' )')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ')' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(')'),
  Rule('', ' }')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == '}' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key('}'),
  Rule('', ' ]')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ']' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(']'),
}
EOF

" gitsigns
lua << EOF
require('gitsigns').setup()
EOF

" fidget
lua << EOF
require("fidget").setup{
    text = {
        spinner = "dots"
    }
}
EOF

" toggleterm
lua << EOF
require('toggleterm').setup{
  open_mapping = [[<C-t>]],
  direction = 'float'
}
EOF

" general settings
set number
set relativenumber
set nowrap
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hidden
set splitbelow
set splitright
set foldmethod=indent
set foldlevel=99
set signcolumn=yes
set shortmess+=c
set updatetime=300
set scrolloff=5
set sidescrolloff=5
syntax enable
filetype plugin indent on

" cursorline
hi CursorLine guibg=#24242e
set cursorline

" my mappings
let mapleader=" "

inoremap kj <Esc>
inoremap jk <Esc>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" telescope for files and buffers
nnoremap <silent> <leader>ff <cmd>Telescope find_files<Cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<Cr>

" lsp shortcuts
" line diagnositc and code actions
nnoremap <silent> <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" diagnostics in current buffer or all buffers
nnoremap <silent> <leader>fd <cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<CR>
nnoremap <silent> <leader>fD <cmd>lua require('telescope.builtin').diagnostics{}<CR>

" symbols in document or workspace
nnoremap <silent> <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols{}<CR>
nnoremap <silent> <leader>fS <cmd>lua require('telescope.builtin').lsp_workspace_symbols{}<CR>

" references, implementations, and definitions
nnoremap <silent> <leader>gr <cmd>lua require('telescope.builtin').lsp_references{}<CR>
nnoremap <silent> <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations{}<CR>
nnoremap <silent> <leader>gd <cmd>lua require('telescope.builtin').lsp_definitions{}<CR>

" pounce
nnoremap <silent> s <cmd>Pounce<CR>
nnoremap <silent> S <cmd>PounceRepeat<CR>
vnoremap <silent> s <cmd>Pounce<CR>
