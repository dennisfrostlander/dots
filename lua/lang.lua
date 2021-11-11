-- Language-specific overrides

-- More convenient html formatter, config in ~/.jsbeautifyrc
vim.api.nvim_exec([[
autocmd FileType html nnoremap <buffer> <Leader>k :Neoformat<CR>
autocmd FileType scss nnoremap <buffer> <Leader>k gg=G<C-O>
]], false)

