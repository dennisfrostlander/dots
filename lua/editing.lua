vim.api.nvim_set_keymap("n", "<Leader>,", "$a,<Esc>", {})
vim.api.nvim_set_keymap("n", "<Leader>;", "$a;<Esc>", {})
vim.api.nvim_set_keymap("n", "<Leader>o", "o<ESC>", {})
vim.api.nvim_set_keymap("n", "<Leader>O", "O<ESC>", {})

vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", {})
vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", {})

-- Keep cursor at the bottom of the visual selection after you yank it.
vim.api.nvim_set_keymap("v", "y", "ygv<ESC>", {})

-- Move the selected region.
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", {noremap=true})
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", {noremap=true})

-- Keep the line centered while.
vim.api.nvim_set_keymap("n", "n", "nzzzv", {noremap=true})
vim.api.nvim_set_keymap("n", "N", "Nzzzv", {noremap=true})
vim.api.nvim_set_keymap("n", "J", "mzJ`z", {noremap=true})

vim.api.nvim_set_keymap("n", "*",
  [[:let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>]],
  {})
vim.api.nvim_set_keymap("n", "<Leader>*",
  [[(&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"]],
  {expr = true})

-- lowercase marks behave like uppercase
vim.api.nvim_set_keymap("n", "'", [["'".toupper(nr2char(getchar()))]],
  {noremap = true, expr = true});
vim.api.nvim_set_keymap("n", "m", [["m".toupper(nr2char(getchar()))]],
  {noremap = true, expr = true});

vim.g.better_whitespace_enabled = false
vim.g.strip_whitespace_on_save = true
vim.g.strip_whitespace_confirm = false
-- vim.g.better_whitespace_guicolor = "#EBCB8B"
vim.g.strip_max_file_size = 1000
vim.g.strip_only_modified_lines = true

vim.g.indentLine_enabled = 1
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
-- vim.g.indent_blankline_show_current_context = true

vim.g.vsnip_snippet_dir = require("utils").config_dir_path() .. "/snippets"

require("colorizer").setup()
require("Comment").setup()

vim.cmd([[
augroup auto_insert
  autocmd!
  au FileType gitcommit,hgcommit startinsert
augroup END
]])
