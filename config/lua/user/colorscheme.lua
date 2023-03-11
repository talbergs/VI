-- so $VIMRUNTIME/syntax/hitest.vim
local colorscheme = "melange"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

-- Trigger this to create pretty highlight groups.
require('nvim-web-devicons').setup();

-- file tree
vim.cmd[[hi NeoTreeIndentMarker guifg=green]]
vim.cmd[[hi NeoTreeDirectoryIcon guifg=green]]
vim.cmd[[hi NeoTreeDirectoryName guifg=green]]
vim.cmd[[hi NeoTreeFileName guifg=green]]

-- lsp
vim.cmd[[hi! DevIconEpp gui=bold]]
vim.cmd[[hi! DevIconSvelte gui=bold]]
vim.cmd[[hi! link LspReferenceRead DevIconEpp]]
vim.cmd[[hi! link LspReferenceWrite DevIconSvelte]]
vim.cmd[[hi! link FloatBorder DevIconSvelte]]
vim.cmd[[hi! link NormalFloat Normal]]

-- php doc block injected language
vim.cmd[[hi! link phpdocTSAttribute Whitespace]]
vim.cmd[[hi! link phpdocTSType Whitespace]]
vim.cmd[[hi! link phpdocTSKeyword Whitespace]]
vim.cmd[[hi! link phpdocTSParameter Whitespace]]
vim.cmd[[hi! link phpdocTSText Comment]]
vim.cmd[[hi! link LspReferenceRead DevIconEpp]]
vim.cmd[[hi! link LspReferenceWrite DevIconSvelte]]

-- TSContext
vim.cmd[[hi! link TreesitterContext StatusLineNC]]

-- VIM
vim.cmd[[hi! link Folded DevIconClojureDart]]
