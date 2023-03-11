vim.cmd[[
" Disable this built-in plugin.
" It has annoying bugs when it is not syntax aware.
let g:loaded_matchparen = 1
" TODO: https://github.com/monkoose/matchparen.nvim/issues/15#issuecomment-1166337380

" Not using this plugin. It gives more "%" motions, like "]%".
" Simple "%" is enough for me.
let g:loaded_matchit = 1

" Not using this plugin this may also be implicitly disabled by nvim-tree.
let g:loaded_netrwPlugin = 1

" Not using this plugin. Why it exists?
let g:loaded_2html_plugin = 1

" Not using this plugin.
let g:loaded_tutor_mode_plugin = 1

" Alias common command typo.
command! Cq :cq

" Not a keybinding
command! SourceInit :source ~/.config/nvim/init.lua

" Takes the first spell suggestion and adds undo marker.
inoremap <c-l> <c-g>u<esc>[s1z=`]a<c-g>u

" split resizing (hold the key for things like "<c-w>_" and "<c-w|"
nnoremap <c-right> :vertical resize +5<cr>
nnoremap <c-left> :vertical resize -5<cr>
nnoremap <c-up> :resize +5<cr>
nnoremap <c-down> :resize -5<cr>

nnoremap gt :tabnew<cr>
nnoremap <a-k> :tabnext<cr>
nnoremap <a-j> :tabprevious<cr>
nnoremap <space>w :w<cr>
nnoremap <space>n :Neotree toggle<cr>
nnoremap <space>N :Neotree reveal<cr>
nnoremap <a-=> :cnext<cr>
nnoremap <a--> :cprev<cr>
nnoremap <a-+> :cnewer<cr>
nnoremap <a-_> :colder<cr>
nnoremap <a->> :tabmove +1<cr>
nnoremap <a-<> :tabmove -1<cr>

" faster vertical scroll
nnoremap <c-y> 2<c-y>
nnoremap <c-e> 2<c-e>

" horizontal scroll
nnoremap <c-l> 2zl
nnoremap <c-h> 2zh

" 10x jumps
nnoremap <c-j> 10j
nnoremap <c-k> 10k
vnoremap <c-j> 10j
vnoremap <c-k> 10k

nnoremap <f1> :se spell!<cr>
nnoremap <f2> :se list!<cr>
nnoremap <f3> :TSContextToggle<cr>
nnoremap <cr> @@

nnoremap Y y$
nnoremap Q :nohl<cr>

" Move lines up and down, while maintaining indentation.
vnoremap <a-j> :m '>+1<CR>gv=gv
vnoremap <a-k> :m '<-2<CR>gv=gv

" I use "S" not "cc", so "cc" might serve another purpose.
" TODO: cc should be convert-case and open menu to choose to do camelcase or
" snakecase etc..
nnoremap cc ct<space>

" Snippet abbreviations not mixed with LSP autocompletes.
" inoremap <c-s> <cmd> lua require'fuzzy-snippet'.main()<cr>
nnoremap <space><space> :lua require'luasnip-telescope'.main()<cr> 
inoremap <c-s> <cmd> lua require'luasnip-telescope'.main()<cr> 

" snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<cr>
" snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<cr>

" imap <expr> <c-k> luasnip#expand_or_jumpable() ? '<plug>luasnip-expand-or-jump' : '<tab>'
" inoremap <c-j> <cmd>lua require'luasnip'.jump(-1)<cr>
" imap <expr> <c-h> luasnip#choice_active() ? '<plug>luasnip-next-choice' : '<c-h>'
" imap <expr> <c-l> luasnip#choice_active() ? '<plug>luasnip-prev-choice' : '<c-l>'

" nnoremap gd <cmd>lua require("mt.goto-def")()<cr>
" nnoremap tgd <cmd>lua require("mt.goto-def-tab")()<cr>

" nnoremap tgd <cmd>tab split \| lua vim.lsp.buf.definition()<cr>


nnoremap <space>f :Telescope find_files<cr>
nnoremap <space>b :Telescope buffers<cr>
nnoremap <space>l :Telescope current_buffer_fuzzy_find<cr>
nnoremap t :Telescope lsp_document_symbols symbols=['method']<cr>

]]

vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', ' a', vim.lsp.buf.code_action)
vim.keymap.set('n', ' r', vim.lsp.buf.rename)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'g d', ':tab split | lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'g s', ':vsp | lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'gh', vim.lsp.buf.document_highlight)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', ' d', vim.diagnostic.open_float)
vim.keymap.set('n', ' t', require('telescope-tabs').list_tabs)
vim.keymap.set('n', ' ^', require('telescope-tabs').go_to_previous)
vim.keymap.set('n', ' s', require'spectre'.open)
vim.keymap.set('n', ' F', function () require'spectre'.open_visual({select_word=true}) end)
-- fast wordjump [b - search backwadrs, W - do not wrap on file, z - start search from column instead of line beginning ]
vim.keymap.set('n', '<c-n>', function () vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'Wz') end)
vim.keymap.set('n', '<c-p>', function () vim.fn.search('\\<' .. vim.fn.expand('<cword>') .. '\\>', 'bWz') end)
