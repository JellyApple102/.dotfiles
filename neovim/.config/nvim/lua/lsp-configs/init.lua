local lspconfig = require('lspconfig')

lspconfig.jedi_language_server.setup{}
lspconfig.tsserver.setup{}

-- ccls
lspconfig.ccls.setup{
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

-- rust-tools
require('rust-tools').setup{
    tools = {
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
}

-- emmet-ls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup{
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    }
}

-- set diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " ", }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end