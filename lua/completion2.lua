vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.pumheight = 30
vim.cmd([[set shortmess+=c]])

vim.cmd([[
autocmd BufEnter * lua require'completion'.on_attach()
]])

vim.api.nvim_set_keymap("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {expr=true})
vim.api.nvim_set_keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {expr=true})
-- vim.api.nvim_set_keymap("i", "C-y", "<Plug>(completion_trigger)", {})
