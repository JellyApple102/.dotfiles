local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require('luasnip')
local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup{
    view = {
        entries = { name = "custom", selection_order = "near_cursor" }
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            elseif luasnip.jumpable(-1) then
                lausnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    },
    sources = {
        { name = 'nvim_lsp', max_item_count = 7 },
        { name = 'luasnip', max_item_count = 7 },
        { name = 'path', max_item_count = 7 },
        { name = 'nvim_lua', max_item_count = 7 },
        -- { name = 'buffer', max_item_count = 7 },
    },
    formatting = {
        format = require('lspkind').cmp_format{
            mode = 'symbol_text',
            menu = {
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                path = '[Path]',
                buffer = '[Buffer]'
            },
        },
    },
}
