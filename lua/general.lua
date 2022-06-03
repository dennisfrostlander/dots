vim.g.mapleader = " "
vim.g.auto_save = 1

vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cmdheight = 1
vim.o.clipboard = "unnamedplus"
vim.o.colorcolumn = "999999"
vim.o.cursorline = true
vim.o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-iCursor,r-cr-o:hor20"
vim.o.hidden = true
vim.o.showcmd = false
vim.o.mouse = "n"
vim.o.ruler = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.updatetime = 250
-- vim.o.virtualedit = "all"
vim.o.wrap = false
vim.o.fillchars = "vert: "
vim.wo.number = true
vim.wo.numberwidth = 2
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

vim.api.nvim_set_keymap("i", "jk", "<ESC>", {})
vim.api.nvim_set_keymap("n", "<leader>w", ":wa<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>q", ":q<CR>", {})
vim.api.nvim_set_keymap("n", "Q", ":q!<CR>", {})

vim.api.nvim_set_keymap("n", "<Leader>yf", [[:let @+ = fnamemodify(expand("%"), ":~:.")<CR>]],
  {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>yF", [[:let @+ = expand("%:p")<CR>]],
  {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>R", [[:luafile %<CR>]],
  {noremap = true})

vim.cmd([[
augroup general
  au!
  au FileType qf wincmd J
augroup END
]])
