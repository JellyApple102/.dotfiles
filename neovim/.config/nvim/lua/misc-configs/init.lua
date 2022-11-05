-- telescope
require('telescope').setup{
    extenstions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown{}
        }
    }
}
require('telescope').load_extenstion('ui-select')
require('telescopt').load_extenstion('fzf')

-- lualine
require('lualine').setup{
    options = {
        theme = 'kanagawa'
    },
    tabline = {},
}

-- treesitter
require('nvim-treesitter.configs').setup{
    hihglight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}
require('treesitter-context').setup{}

-- gitsigns
require('gitsigns').setup()

-- fidget
require('fidget').setup{
    text = {
        spinner = 'dots'
    }
}

-- toggleterm
require('toggleterm').setup{
    open_mapping = [[<C-t>]],
    direction = 'float'
}
