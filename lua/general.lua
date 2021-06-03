vim.g.mapleader = " "
vim.g.auto_save = 1

vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cmdheight = 1
vim.o.cursorline = true
vim.o.hidden = true
vim.o.mouse = "n"
vim.o.ruler = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.virtualedit = "all"
vim.wo.relativenumber = true
vim.o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-iCursor,r-cr-o:hor20"
vim.o.colorcolumn = "999999"

vim.cmd "colorscheme nord"
vim.cmd "syntax enable"
vim.cmd "syntax on"

-- Persistent undo
vim.cmd([[
let undo_dir=$HOME.'/.vim/undo'
if !isdirectory(undo_dir)
    call mkdir(undo_dir, 'p')
endif
set undofile
let &undodir=undo_dir
]])

