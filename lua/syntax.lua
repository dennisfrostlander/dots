vim.cmd "syntax manual"

vim.cmd([[
augroup syntax
  autocmd!
  au FileType html,yaml,gitcommit,sh,zsh set syntax=ON
augroup END
]])

local ts_config = require("nvim-treesitter.configs")
ts_config.setup {
  ensure_installed = {
    "typescript",
    "javascript",
    "html",
    "css",
    "bash",
    "cpp",
    "rust",
    "lua"
  },
  highlight = {
    enable = true,
    disable = { "html" },
    -- use_languagetree = true
    custom_captures = {
      ["gmacros"] = "gmacros",
      ["gmacrosSubtle"] = "gmacrosSubtle",
      ["gmacroTest"] = "gmacroTest",
      ["gmacroTestParameter"] = "gmacroTestParameter",
      ["cppNamespaceDefinition"] = "cppNamespaceDefinition",
      ["cppFunctionDeclaration"] = "cppFunctionDeclaration",
      ["cppQualifiedIdentifier"] = "cppQualifiedIdentifier",
      ["cppExtraKeywords"] = "cppExtraKeywords",
    },
  },
}

vim.cmd[[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
]]

-- require "nvim-treesitter.configs".setup {
--   playground = {
--     enable = true,
--     disable = {},
--     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--     persist_queries = false, -- Whether the query persists across vim sessions
--     keybindings = {
--       toggle_query_editor = 'o',
--       toggle_hl_groups = 'i',
--       toggle_injected_languages = 't',
--       toggle_anonymous_nodes = 'a',
--       toggle_language_display = 'I',
--       focus_language = 'f',
--       unfocus_language = 'F',
--       update = 'R',
--       goto_node = '<cr>',
--       show_help = '?',
--     },
--   }
-- }
