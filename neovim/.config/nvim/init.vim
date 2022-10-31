" plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'rebelot/kanagawa.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'aca/emmet-ls'
Plug 'folke/trouble.nvim'
Plug 'rlane/pounce.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'akinsho/toggleterm.nvim', { 'tag' : 'v2.*' }
Plug 'SmiteshP/nvim-navic'

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
EOF

" navic
lua << EOF
require('nvim-navic').setup{}
EOF

" lualine
lua << EOF
local navic = require('nvim-navic')

require('lualine').setup {
    options = {
        theme = 'kanagawa'
    },
    tabline = {},
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        }
    }
}
EOF

" bufferline
lua << EOF
require("bufferline").setup{
    options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
        persist_buffer_sort = true,
    }
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
EOF

" LSP
lua << EOF
require'lspconfig'.jedi_language_server.setup{
    on_attach = function(client, bufnr)
        require('nvim-navic').attach(client, bufnr)
    end
}

-- require'lspconfig'.jdtls.setup{
--     on_attach = function(client, bufnr)
--         require('nvim-navic').attach(client, bufnr)
--     end,
--     cmd = { 'jdtls' },
--     root_dir = function(fname)
--         return require'lspconfig'.util.root_pattern('pom.xml', 'gradel.build', '.git')(fname) or vim.fn.getcwd()
--     end,
--     init_options = {
--         extendedClientCapabilities = {
--             progressReportProvider = false,
--         },
--     },
-- }

-- require('lspconfig').jdtls.setup{}
EOF

" ccls
lua << EOF
local lspconfig = require'lspconfig'
local util = lspconfig.util
lspconfig.ccls.setup {
    on_attach = function(client, bufnr)
        require('nvim-navic').attach(client, bufnr)
    end,
    init_options = {
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        clang = {
            excludeArgs = { "-frounding-math" };
        };
    },
    --root_dir = util.root_pattern("compile_commands.json", ".ccls", ".git") or dirname
}
EOF

" configure rust-analyzer through rust-tools
lua << EOF
local nvim_lsp = require'lspconfig'
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    server = {
        on_attach = function(client, bufnr)
            require('nvim-navic').attach(client, bufnr)
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
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

lua << EOF
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " ", }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

lua << EOF
require('lspconfig').tsserver.setup{}
EOF

" completion
set completeopt=menuone,noinsert,noselect

lua << EOF
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require'luasnip'
local cmp = require 'cmp'
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
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

" trouble
lua << EOF
require("trouble").setup {}
EOF

" scrollbar
lua << EOF
local colors = require("kanagawa.colors").setup()
require("scrollbar").setup{
    handle = {
        color = colors.sumiInk3,
    },
}
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
" set sessionoptions+=winpos,terminal
" set list
" set listchars=tab:\|\ ,eol:↴,trail:·
syntax enable
filetype plugin indent on

" cursorline
" hi clear CursorLine
hi CursorLine guibg=#24242e
set cursorline

" my mappings
inoremap kj <Esc>
inoremap jk <Esc>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" pounce
nnoremap <silent> s <cmd>Pounce<CR>
nnoremap <silent> S <cmd>PounceRepeat<CR>
vnoremap <silent> s <cmd>Pounce<CR>

" telescope
nnoremap <silent> ff <cmd>Telescope find_files<Cr>
nnoremap <silent> fb <cmd>Telescope buffers<Cr>
nnoremap <silent> fg <cmd>Telescope live_grep<Cr>
nnoremap <silent> fh <cmd>Telescope help_tags<Cr>

" trouble
nnoremap <silent> <leader>xx <cmd>TroubleToggle<cr>

" lsp navigation shortcuts
nnoremap <silent> <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> gr    <cmd>lua require('telescope.builtin').lsp_references{}<CR>
nnoremap <silent> gd    <cmd>lua require('telescope.builtin').lsp_implementations{}<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" bufferline
nnoremap <silent> <leader>gb <cmd>BufferLinePick<CR>
nnoremap <silent> <leader>bl <cmd>BufferLineMoveNext<CR>
nnoremap <silent> <leader>bh <cmd>BufferLineMovePrev<CR>
nnoremap <silent> <C-l> <cmd>BufferLineCycleNext<CR>
nnoremap <silent> <C-h> <cmd>BufferLineCyclePrev<CR>
