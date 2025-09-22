local jdtls = require('jdtls')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = vim.fn.expand('~/jdt-workspaces/') .. project_name

local bundles = {
  vim.fn.glob('~/repos/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true),
};
vim.list_extend(bundles, vim.split(vim.fn.glob('~/repos/vscode-java-test/server/*.jar', true), '\n'))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'jdtls',
    '-configuration', vim.fn.expand('~/.cache/jdtls/'),

    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'jbuild.yaml' }, { upward = true })[1]),
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = {
        enabled = true
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '/data/data/com.termux/files/usr/lib/jvm/java-21-openjdk'
          },
          {
            name = 'JavaSE-17',
            path = '/data/data/com.termux/files/usr/lib/jvm/java-17-openjdk'
          },
        }
      },
      inlayhints = {
        parameterNames = {
          enabled = 'all',
        }
      }
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities,
  },

  capabilities = Lsp_capabilities
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
vim.keymap.set('n', Lsp_leader .. 'o', jdtls.organize_imports, { desc = 'Organize Imports', buffer = 0 })
vim.keymap.set({ 'n', 'v' }, Lsp_leader .. 'xv', function()
  if vim.api.nvim_get_mode().mode == 'n' then
    jdtls.extract_variable()
  elseif vim.api.nvim_get_mode() == 'v' then
    jdtls.extract_variable({ visual = true })
  else
    return
  end
end, { desc = 'Extract Variable', buffer = 0 })

vim.keymap.set({ 'n', 'v' }, Lsp_leader .. 'xc', function()
  if vim.api.nvim_get_mode().mode == 'n' then
    jdtls.extract_constant()
  elseif vim.api.nvim_get_mode() == 'v' then
    jdtls.extract_constant({ visual = true })
  else
    return
  end
end, { desc = 'Extract Constant', buffer = 0 })

vim.keymap.set({ 'v' }, Lsp_leader .. 'xf', function()
  jdtls.extract_method({ visual = true })
end, { desc = 'Extract Method', buffer = 0 })

vim.keymap.set({ 'n' }, Lsp_leader .. 'tc', jdtls.test_class, {desc = "Test Class", buffer = 0})
vim.keymap.set({ 'n' }, Lsp_leader .. 'tf', jdtls.test_class, {desc = "Test Method", buffer = 0})
