local o          = vim.opt
local g          = vim.g
g.mapleader      = " "
g.maplocalleader = " "

o.hlsearch = false
o.incsearch = true

o.number         = true  -- show absolute line number
o.ignorecase     = true  -- ignore case in search patterns
o.relativenumber = true  -- show relative line numbers
o.termguicolors  = true  -- enable 24-bit colors

o.tabstop        = 2     -- number of spaces that a <Tab> in the file counts for
o.shiftwidth     = 2     -- size of an indent
o.expandtab      = true  -- use spaces instead of tabs

o.smartindent    = true  -- auto-indent new lines

o.swapfile       = false -- disable swapfiles

o.backup         = false -- disable backup files

o.undofile       = true  -- enable persistent undo

o.updatetime     = 50   -- faster completion

o.scrolloff      = 8     -- keep cursor 8 lines from screen edge

o.signcolumn     = "yes" -- always show sign column

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
