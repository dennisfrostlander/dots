vim.api.nvim_set_keymap("n", "<Leader>,", "$a,<Esc>", {})
vim.api.nvim_set_keymap("n", "<Leader>;", "$a;<Esc>", {})
vim.api.nvim_set_keymap("n", "<Leader>o", "o<ESC>", {})
vim.api.nvim_set_keymap("n", "<Leader>O", "O<ESC>", {})

vim.api.nvim_set_keymap("n", "[q", ":cnext<CR>", {})
vim.api.nvim_set_keymap("n", "]q", ":cprev<CR>", {})

-- Keep cursor at the bottom of the visual selection after you yank it.
vim.api.nvim_set_keymap("v", "y", "ygv<ESC>", {})

vim.g.better_whitespace_enabled = true
vim.g.strip_whitespace_on_save = true
vim.g.strip_whitespace_confirm = false
vim.g.better_whitespace_guicolor = "#B48EAD"

require('nvim-autopairs').setup({
  check_line_pair = false
})
