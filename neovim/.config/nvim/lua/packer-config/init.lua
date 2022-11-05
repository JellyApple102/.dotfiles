return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'rebelot/kanagawa.nvim' }
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'lewis6991/gitsigns.nvim' }
    use { 'windwp/nvim-autopairs' }
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
    use { 'neovim/nvim-lspconfig' }
    use { 'simrat39/rust-tools.nvim' }
    use { 'mfussenegger/nvim-jdtls' }
    use { 'aca/emmet-ls' }
    use { 'j-hui/fidget.nvim' }
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
    use { 'rlane/pounce.nvim' }
    use { 'akinsho/toggleterm.nvim' }
end)
