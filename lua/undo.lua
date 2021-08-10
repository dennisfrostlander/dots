-- Persistent undo
vim.cmd([[
let undo_dir=$HOME.'/.vim/undo'
if !isdirectory(undo_dir)
    call mkdir(undo_dir, 'p')
endif
set undofile
let &undodir=undo_dir
]])

