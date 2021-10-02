require("gitsigns").setup {
  -- signs = {
  --     add = {hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr"},
  --     change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
  --     delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
  --     topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
  --     changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
  -- },
  numhl = false,
  keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
      ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
      ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
  },
  watch_index = {
      interval = 100
  },
  sign_priority = 5,
  status_formatter = nil -- Use default
}

local diffview = require'diffview.config'.diffview_callback
require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
  },
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = diffview("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]   = diffview("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = diffview("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = diffview("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = diffview("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]        = diffview("next_entry"),
      ["k"]             = diffview("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]          = diffview("prev_entry"),
      ["<cr>"]          = diffview("select_entry"),       -- Open the diff for the selected entry.
      ["o"]             = diffview("select_entry"),
      ["<2-LeftMouse>"] = diffview("select_entry"),
      ["-"]             = diffview("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["S"]             = diffview("stage_all"),          -- Stage all entries.
      ["U"]             = diffview("unstage_all"),        -- Unstage all entries.
      ["X"]             = diffview("restore_entry"),      -- Restore entry to the state on the left side.
      ["R"]             = diffview("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]         = diffview("select_next_entry"),
      ["<s-tab>"]       = diffview("select_prev_entry"),
      ["<leader>e"]     = diffview("focus_files"),
      ["<leader>b"]     = diffview("toggle_files"),
    }
  }
}
vim.api.nvim_set_keymap("n", "<Leader>hd", ":DiffviewOpen<CR>", {noremap=true})
