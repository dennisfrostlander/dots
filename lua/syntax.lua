vim.cmd "syntax manual"

vim.cmd([[
augroup syntax
  au!
  au BufRead,BufNewFile *.log,*.STDERR,*.STDOUT,*.ERROR,*.INFO,*.WARNING set filetype=log
  au FileType html,yaml,gitcommit,hgcommit,proto,bzl,sh,zsh,tmux,conf,markdown,vim,help,sdl,log setlocal syntax=ON
  au FileType textproto setlocal syntax=conf
augroup END
]])

local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.gcl = {
  install_info = {
    url = "https://github.com/dennisfrostlander/tree-sitter-gcl", -- local path or git repo
    -- url = "~/projects/tree-sitter-gcl", -- local path or git repo
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false -- if folder contains pre-generated src/parser.c
  }
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "typescript", "tsx", "javascript", "html", "css", "scss", "bash", "cpp", "rust",
    "java", "python", "go", "gcl", "json", "lua"
  },
  highlight = {
    enable = true,
    disable = {"html"},
    -- use_languagetree = true
    custom_captures = {
      ["cppConstant"] = "Nord7",
      ["gmacrosSubtle"] = "CommentItalic",
      ["cppNamespaceDefinition"] = "Identifier",
      ["cppNamespaceDefinitionName"] = "Identifier",
      ["cppFunctionDeclaration"] = "TSKeyword",
      ["cppQualifiedIdentifier"] = "TSType",
      ["cppExtraKeywords"] = "TSKeyword",

      ["cssClass"] = "TSType"
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
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
      show_help = '?'
    }
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer"
      }
    },
    swap = {
      enable = true,
      swap_next = {["<Leader>a"] = "@parameter.inner"},
      swap_previous = {["<Leader>A"] = "@parameter.inner"}
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer"
      }
    }
  }
}

vim.cmd [[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set foldlevelstart=99
]]
