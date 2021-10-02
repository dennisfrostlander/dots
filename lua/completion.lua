vim.cmd [[packadd nvim-lspconfig]]

vim.o.completeopt = "menuone,noinsert,preview"
vim.o.pumheight = 30

local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'spell' },
  },
  completion = {
    -- Preselect
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      return vim_item
    end
  }
})

require("nvim-autopairs").setup({
  check_line_pair = false,
})
-- you need setup cmp first put this after cmp.setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true,
  insert = false,
})

vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr=true})
