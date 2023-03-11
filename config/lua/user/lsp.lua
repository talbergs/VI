-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'php',
--   callback = function()
--     vim.lsp.start({
--       name = 'intelephense',
--       cmd = {'intelephense', '--stdio'},
--       root_dir = vim.fs.dirname(vim.fs.find({'composer.json', '.git'}, { upward = true })[1]),
--     })
--   end,
-- })

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')

-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

lspconfig.intelephense.setup({});

-- lspconfig.rnixs.setup({}); -- Not maintained? Less suggestions.
lspconfig.nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
});

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.code_actions.statix,
    require('null-ls').builtins.diagnostics.statix,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
