local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}
local user = vim.fn.expand("$USER")
local ws_pattern = "(/google/src/cloud/"..user.."/)([%a%d]+)(.*)"

local function get_workspace_dir(ws)
  return "/google/src/cloud/"..user.."/"..ws
end

local function parse_workspace_path(p)
  local _, _, prefix, ws, suffix = string.find(p, ws_pattern)
  return ws, prefix, suffix
end

local function add_recent_file(cur_ws, results, file_path, opts)
  if cur_ws then
    local ws, prefix, suffix = parse_workspace_path(file_path)
    if ws and ws ~= cur_ws then
      file_path = prefix .. cur_ws .. suffix
    end
  end
  local ignored = false
  if vim.tbl_contains(results, file_path) then
    ignored = true
  end
  if opts.ignore_pattern and string.find(file_path, opts.ignore_pattern) == 1 then
    ignored = true
  end
  if not ignored then
    table.insert(results, file_path)
  end
end

M.recent_files = function(opts)
  opts = opts or {}
  opts.ignore_pattern = opts.ignore_pattern or "/google/obj/workspace/"
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local results = {}
  local cur_ws = parse_workspace_path(vim.fn.getcwd())

  for _, file in ipairs(vim.v.oldfiles) do
    if file ~= current_file then
      add_recent_file(cur_ws, results, file, opts)
    end
  end
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local file = vim.api.nvim_buf_get_name(buffer)
      if file ~= current_file then
        add_recent_file(cur_ws, results, file, opts)
      end
    end
  end

  pickers.new(opts, {
    prompt_title = "Oldfiles",
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.generic_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

local cached_workspaces = nil
M.find_workspaces = function(opts)
  opts = opts or {}
  local results = {}

  local workspaces = cached_workspaces or vim.fn.systemlist('hg citc -l')
  cached_workspaces = workspaces
  for _, ws in ipairs(workspaces) do
    table.insert(results, ws)
  end

  pickers.new(opts, {
    prompt_title = "Workspaces",
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("cd " .. get_workspace_dir(selection[1]))
      end)
      return true
    end,
  }):find()
end

return M
