vim.cmd[[let g:nord_enable_treesitter=1]]
require("plugins")

require("utils.lua")
require("web-devicons.lua")

require("general")
require("editing")
require("lua_lsp")
require("telescope-config")
require("completion")

-- lsp
require("nvim-lspconfig.lua")

require("gitsigns.lua")
require("file_search")

require"colorizer".setup()

require("treesitter.lua")
require("mappings.lua")

require("nvim-autopairs").setup()

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- Nord tree-sitter overrides
vim.cmd[[
hi! link TSType Function
hi! link TSVariableBuiltin Keyword
hi! link TSBoolean Number
hi! link TSConstructor Function
hi! TSFunction gui=italic guifg=#88C0D0
hi! TSParameter gui=italic guifg=#D8DEE9
]]
