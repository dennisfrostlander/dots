vim.g.ranger_map_keys = 0
vim.g.floaterm_opener = "edit"
vim.g.lf_map_keys = 0
vim.g.lf_replace_netrw = 1

vim.api.nvim_set_keymap("n", "<Leader>e", ":LfCurrentFile<CR>", {})
vim.api.nvim_set_keymap("n", "*",
                        [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]],
                        {})
vim.api.nvim_set_keymap("n", "<Leader>*",
                        [[(&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"]],
                        {expr = true})
