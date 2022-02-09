vim.cmd [[packadd nvim-lspconfig]]

vim.o.completeopt = "menuone,noinsert,preview,noselect"
vim.o.pumheight = 30

local lspkind = require('lspkind')
local cmp = require('cmp')
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
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer',
      options = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = 'path' },
    { name = 'spell' },
  },
  -- completion = {
  --   -- Preselect
  --   completeopt = 'menu,menuone,noinsert',
  -- },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.menu = ({
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        path = "[path]",
        vsnip = "[snip]",
      })[entry.source.name]
      return vim_item
    end
  }
})

require("nvim-autopairs").setup({
})
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require('cmp')
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

vim.api.nvim_set_keymap("i", "<C-l>", "vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-l>'",
  {expr=true})
vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-j>'",
  {expr=true})
vim.api.nvim_set_keymap("i", "<C-k>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'",
  {expr=true})
