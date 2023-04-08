-- telescope
require('telescope').setup{
    defaults = {
        layout_strategy = 'vertical'
    },
    extenstions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown{}
        }
    }
}
require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')

-- lualine
require('lualine').setup{
    options = {
        theme = 'kanagawa'
    },
    tabline = {},
}

-- treesitter
require('nvim-treesitter.configs').setup{
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true
    }
}
require('treesitter-context').setup{}
require('nvim-ts-autotag').setup{}

-- mkdnflow
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

-- surround
require('nvim-surround').setup{}

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

-- easyread
require('easyread').setup{}

-- flote
require('flote').setup{}

-- clear Todo highlight (no weird highlighting in markdown todo lists)
vim.api.nvim_set_hl(0, 'Todo', {})
