return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- theming
    use { 'rebelot/kanagawa.nvim' }
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'lewis6991/gitsigns.nvim' }

    -- utils
    use { 'windwp/nvim-autopairs' }
    use { 'kylechui/nvim-surround' }
    use { 'windwp/nvim-ts-autotag' }
    use { 'rlane/pounce.nvim' }
    use { 'akinsho/toggleterm.nvim' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'jakewvincent/mkdnflow.nvim' }

    -- LSP
    use { 'neovim/nvim-lspconfig' }
    use { 'simrat39/rust-tools.nvim' }
    use { 'mfussenegger/nvim-jdtls' }
    use { 'aca/emmet-ls' }
    use { 'j-hui/fidget.nvim' }

    -- autocomplete and snippets
    use { 'L3MON4D3/LuaSnip' }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip'
        }
    }
    use { 'onsails/lspkind-nvim' }

    -- personal development
    use { 'JellyApple102/easyread.nvim' }
    -- use { '~/randprojects/easyread' }
    use { 'JellyApple102/flote.nvim' }
    -- use { '~/randprojects/flote/' }
end)
