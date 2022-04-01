vim.cmd "syntax manual"

vim.cmd([[
augroup syntax
  au!
  au FileType html,yaml,gitcommit,hgcommit,proto,bzl,sh,zsh,tmux,conf,markdown setlocal syntax=ON
augroup END
]])

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.gcl = {
  install_info = {
    url = "https://github.com/dennisfrostlander/tree-sitter-gcl", -- local path or git repo
    -- url = "~/projects/tree-sitter-gcl", -- local path or git repo
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
}

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
    "java",
    "python",
    "go",
    "gcl",
    "json",
    "lua"
  },
  highlight = {
    enable = true,
    disable = { "html" },
    -- use_languagetree = true
    custom_captures = {
      ["gmacros"] = "Nord7",
      -- ["gmacrosSubtle"] = "CommentItalic",
      ["gmacroTest"] = "Nord7",
      ["gmacroTestParameter"] = "Identifier",
      -- ["cppNamespaceDefinition"] = "cppNamespaceDefinition",
      -- ["cppFunctionDeclaration"] = "cppFunctionDeclaration",
      -- ["cppQualifiedIdentifier"] = "Type",
      -- ["cppExtraKeywords"] = "Keyword",
    },
  },
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

vim.cmd[[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set foldlevelstart=99
]]

