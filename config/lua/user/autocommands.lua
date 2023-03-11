local group = vim.api.nvim_create_augroup("CatchAll", {clear = true});

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
      ]]
  end,
})

-- Prettify quickfix window. Window local highlight change.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "qf" },
  callback = function()
    vim.cmd [[
        setl signcolumn=no
        setl colorcolumn=0
        setl norelativenumber
        setl winhighlight=Normal:Delimiter
        ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "lua" },
  callback = function()
    vim.cmd [[
      setl tabstop=2
      ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "nix" },
  callback = function()
    vim.cmd [[
      setl tabstop=2
      setl iskeyword-=-
      ]]
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = group,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = group,
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {on_visual=false}
  end
});

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*.php",
  group = group,
  callback = vim.lsp.buf.clear_references,
});

