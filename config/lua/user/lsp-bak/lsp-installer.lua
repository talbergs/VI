local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "sumneko_lua",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "intelephense",
  -- "php-sense",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "intelephense" then
    local intelephense_opts = require "user.lsp.settings.intelephense"
    opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
  end

  -- if server == "php-sense" then
  --   local phpsense_opts = require "user.lsp.settings.php-sense"
  --   -- opts = vim.tbl_deep_extend("force", phpsense_opts, opts)
  --   opts = vim.tbl_deep_extend("force", phpsense_opts, opts)
  -- end

  lspconfig[server].setup(opts)
end

local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.phpsense then
  configs.phpsense = {
    default_config = {
      cmd = {
        'php-sense',
      };
      -- filetypes = {'php', 'sense'};
      filetypes = {'sense'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end;
      settings = {};
    };
  }
end

lspconfig.phpsense.setup{}
vim.cmd[[au BufEnter *.sense se ft=sense syntax=php]]

-- local configs = require 'lspconfig.configs'
-- local lspconfigs = require('lspconfig')
-- local lsp_util = require 'lspconfig.util'
-- if not configs.snyk then
--   configs.snyk = {
--     default_config = {
--       cmd = {
--         'snyk-ls',
--         '-f', '/tmp/snyk-ls.log',
--         '-c', '/home/mt/.config/configstore/snyk.env',
--         '-l', 'trace',
--         '-reportErrors',
--       },
--       filetypes = { 'php', 'dockerfile', 'json' },
--       -- root_dir = lsp_util.find_git_ancestor,
--       root_dir = function(pattern)
--         local cwd = vim.loop.cwd()
--         local root = lsp_util.root_pattern('composer.json', '.git')(pattern)

--         -- prefer cwd if root is a descendant
--         return lsp_util.path.is_descendant(cwd, root) and cwd or root
--       end,
--       init_options = {}
--     };
--   }
-- end

-- lspconfigs.snyk.setup {
--     on_attach = require("user.lsp.handlers").on_attach,
--     capabilities = require("user.lsp.handlers").capabilities,
--     settings = {},
-- }
