local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup({
    -- theming
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup{
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = 'none',
                            }
                        }
                    }
                }
            }
            vim.cmd([[colorscheme kanagawa]])
        end
    },
    {
        'hoob3rt/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'kanagawa'
                },
                tabline = {},
            }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{}
        end
    },

    -- utils
    {
        'windwp/nvim-autopairs',
        lazy = true
    },
    {
        'kylechui/nvim-surround',
        version = '*',
        config = function()
            require('nvim-surround').setup{}
        end
    },
    {
        'rlane/pounce.nvim',
        keys = {
            { 's', '<cmd>Pounce<CR>' }
        },
        config = function()
            require('pounce').setup{}
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = {
            { '<C-t>', '<cmd>ToggleTerm<CR>' }
        },
        config = function()
            require('toggleterm').setup{
                direction = 'float'
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup{
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                }
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup{}
        end
    },
    {
        'windwp/nvim-ts-autotag',
        ft = 'typescriptreact',
        config = function()
            require('nvim-ts-autotag').setup{}
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    layout_strategy = 'vertical'
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown()
                    }
                }
            }
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('fzf')
        end
    },
    {
        'jakewvincent/mkdnflow.nvim',
        ft = 'markdown',
        config = function()
            require('mkdnflow').setup{
                modules = {
                    bib = false,
                    buffers = false,
                    conceal = false,
                    cursor = false,
                    folds = false,
                    links = false,
                    lists = true,
                    maps = false,
                    tables = false,
                    yaml = false
                }
            }
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        lazy = true
    },
    {
        'simrat39/rust-tools.nvim',
        lazy = true
    },
    {
        'mfussenegger/nvim-jdtls',
        lazy = true
    },
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup{
                text = {
                    spinner = 'dots'
                }
            }
        end
    },

    -- autocomplete and snippets
    {
        'L3MON4D3/LuaSnip',
        lazy = true
    },
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip'
        }
    },
    {
        'onsails/lspkind-nvim',
        lazy = true
    },

    -- personal
    {
        'JellyApple102/easyread.nvim',
        ft = 'text',
        config = function()
            require('easyread').setup{}
        end
    },
    {
        'JellyApple102/flote.nvim',
        keys = {
            { '<leader>on', '<cmd>Flote<CR>' }
        },
        config = function()
            require('flote').setup{}
        end
    }
})
