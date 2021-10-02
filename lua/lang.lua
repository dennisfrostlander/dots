-- Language-specific overrides

-- More convenient html formatter, config in ~/.jsbeautifyrc
vim.api.nvim_exec([[
autocmd FileType html nnoremap <buffer> <Leader>k :silent !js-beautify -r %<CR>
]], false)

