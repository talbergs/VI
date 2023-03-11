-- Check the progress.
-- https://github.com/nanotee/nvim-lua-guide
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.listchars = 'space:⋅,trail:•,tab:˖ ,nbsp:⦸,extends:»,precedes:«,eol:↵'
-- vim.o.shortmess = "IWcFqT"
vim.o.scrolloff = 2
vim.o.swapfile = false
-- %s/foo/bar will render substitution as you type
vim.o.inccommand = 'nosplit'
-- indefinitely wait for key press to complete a mapping
vim.o.timeout = false
-- Across OS restarts file can undo :h undo-persistence
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME')..'/.cache/vim-undo'
vim.o.hidden = true
vim.o.showmode = false
vim.o.showcmd = false
vim.o.updatetime = 100 -- 100ms

vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:2'
vim.wo.colorcolumn = '120'
vim.wo.foldmethod = 'indent'
vim.wo.foldlevel = 99

-- Check the progress.
-- https://github.com/neovim/neovim/pull/13479
local o = function(k, v)
    vim.bo[k] = v
    vim.o[k] = v
end

o('swapfile', false)
o('expandtab', true)
o('tabstop', 4)
o('shiftwidth', 0) -- Shiftwidth is equal to tabstop when it is zero.

-- " j	Where it makes sense, remove a comment leader when joining lines.  For
-- " 	example, joining:
-- " 		int i;   // the index ~
-- " 		         // in the list ~
-- " 	Becomes:
-- " 		int i;   // the index in the list ~
-- "  Where it makes sense, remove a comment leader when joining lines. For example, joining.

-- " q	Allow formatting of comments with "gq".
-- " 	Note that formatting will not change blank lines or lines containing
-- " 	only the comment leader.  A new paragraph starts after such a line,
-- " 	or when the comment leader changes.
-- setl formatoptions+=q

-- " r	Automatically insert the current comment leader after hitting
-- " 	<Enter> in Insert mode.
-- " 	NOTE: use "o" to begin a new line without 

-- " -- hazard option, should be disabled by default.
-- "
-- " o	Automatically insert the current comment leader after hitting 'o' or
-- " 	'O' in Normal mode.
-- " setl formatoptions+=o
o('formatoptions', 'jqr') -- Shiftwidth is equal to tabstop when it is zero.

