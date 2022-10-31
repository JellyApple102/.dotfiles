vim.lsp.set_log_level(1)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/Users/jacobcarryer/Library/java/jdt-language-server-1.15.0-202208310248/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/Users/jacobcarryer/Library/java/jdt-language-server-1.15.0-202208310248/config_mac',
    '-data', vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
    }
  },
  init_options = {
    --bundles = {}
    extendedClientCapabilities = {
        progressReportProvider = false
    }
  },
}

require('jdtls').start_or_attach(config)
