local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local workspace = require("workspace")

local preview_maker_no_highlight = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = false
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

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
      layout_strategy = "horizontal",
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      file_ignore_patterns = {},
      generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
      shorten_path = true,
      winblend = 0,
      layout_config = {
        horizontal = {mirror = false, preview_width = 0.5},
        vertical = {mirror = false},
        width = 0.75,
        prompt_position = "bottom",
        preview_cutoff = 120,
      },
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

local opt = {noremap = true, silent = true}

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

vim.g.mapleader = " "

-- mappings
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
vim.api.nvim_set_keymap("n", "<Leader><TAB>",
                        [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]],
                        opt)
vim.api.nvim_set_keymap("n", "<Leader>j",
                        [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]],
                        opt)
vim.api.nvim_set_keymap("n", "<Leader>fs",
                        [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
                        opt)
vim.api.nvim_set_keymap("n", "gr",
                        [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]],
                        opt)

