local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local workspace = require("workspace")

-- LF file manager
vim.g.floaterm_opener = "edit"
vim.g.lf_map_keys = 0
vim.g.lf_replace_netrw = 1
vim.api.nvim_set_keymap("n", "<Leader>e", ":LfCurrentFile<CR>", {})

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case"
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    file_ignore_patterns = {},
    generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
    winblend = 0,
    layout_config = {
      width = 0.75,
      prompt_position = "bottom",
    },
    path_display = function(opts, path)
      -- Do common substitutions
      path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
      path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
      path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
      path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
      path = path:gsub("^google3/", "g3/", 1)
      -- Do truncation. This allows us to combine our custom display formatter
      -- with the built-in truncation.
      -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
      -- Here we are manually propagating this value between new_opts and opts.
      -- We can make this cleaner and more complicated using metatables :)
      local new_opts = {
        path_display = {
          truncate = true,
        },
        __length = opts.__length,
      }
      path = require('telescope.utils').transform_path(new_opts, path)
      opts.__length = new_opts.__length
      return path
    end,
    border = {},
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    use_less = true,
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    file_previewer = require"telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-l>"] = actions.send_to_qflist,
      },
      n = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next
      }
   }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require("telescope").load_extension("fzf")

_G.find_files = function()
  require('telescope.builtin').find_files({
    search_dirs = workspace.get_workspace_dirs()
  })
end
_G.live_grep = function()
  require('telescope.builtin').live_grep({
    search_dirs = workspace.get_workspace_dirs()
  })
end

-- mappings
local opt = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "<Leader><Space>",
  [[<Cmd>lua require('navigation_piper').oldfiles()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>m",
  [[:lua find_files()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fp",
  [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fb",
  [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fh",
  [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fg",
  [[:lua live_grep()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fd",
  [[<Cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]],
  opt)
vim.api.nvim_set_keymap("n", "<Leader>fs",
  [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
  opt)

vim.api.nvim_set_keymap("n", "<Leader>fw",
  [[<Cmd>lua require('navigation_piper').find_workspaces()<CR>]],
  opt)

vim.api.nvim_set_keymap("n", "gr",
  [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]],
  opt)
-- vim.api.nvim_set_keymap("n", "<Leader>j",
--                         [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]],
--                         opt)
