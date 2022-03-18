local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values

local M = {}
local user = vim.fn.expand("$USER")
local ws_pattern = "(/google/src/cloud/"..user.."/)([%a%d]+)(.*)"

function getWorkspace(p)
  _, _, prefix, ws, suffix = string.find(p, ws_pattern)
  return ws, prefix, suffix
end

M.oldfiles = function(opts)
  opts = opts or {}
  opts.ignore_pattern = opts.ignore_pattern or "/google/obj/workspace/"
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local results = {}
  local cur_ws = getWorkspace(vim.fn.getcwd())

  for _, file in ipairs(vim.v.oldfiles) do
    if vim.loop.fs_stat(file) and not vim.tbl_contains(results, file) and file ~= current_file then
      if cur_ws then
        local ws, prefix, suffix = getWorkspace(file)
        if ws and ws ~= cur_ws then
          file = prefix .. cur_ws .. suffix
        end
      end
      local ignored = false
      if opts.ignore_pattern and string.find(file, opts.ignore_pattern) == 1 then
        ignored = true
      end
      if not ignored then
        table.insert(results, file)
      end
    end
  end

  pickers.new(opts, {
    prompt_title = "Oldfiles",
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

return M
