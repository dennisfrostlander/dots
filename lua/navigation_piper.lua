local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require"telescope.config".values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}
local user = vim.fn.expand("$USER")
local ws_pattern = "(/google/src/cloud/" .. user .. "/)([%a%d]+)(.*)"

local recent_bufs = {}
local recent_cnt = 0

_G.recents_buf_enter = function()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  if current_file ~= "" then
    recent_bufs[current_file] = recent_cnt
    recent_cnt = recent_cnt + 1
  end
end

vim.cmd [[
augroup recents
  au!
  au! BufEnter * lua recents_buf_enter(123)
augroup END
]]

local function get_workspace_dir(ws)
  return "/google/src/cloud/" .. user .. "/" .. ws
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
  local old_files_map = {}

  for i, file in ipairs(vim.v.oldfiles) do
    if file ~= current_file then
      add_recent_file(cur_ws, results, file, opts)
      old_files_map[file] = i
    end
  end
  for _, buffer_file in ipairs(recent_bufs) do
    if buffer_file ~= current_file then
      add_recent_file(cur_ws, results, buffer_file, opts)
    end
  end
  table.sort(results, function(a, b)
    local a_recency = recent_bufs[a]
    local b_recency = recent_bufs[b]
    if a_recency == nil and b_recency == nil then
      local a_old = old_files_map[a]
      local b_old = old_files_map[b]
      if a_old == nil and b_old == nil then
        return a < b
      end
      if a_old == nil then
        return false
      end
      if b_old == nil then
        return true
      end
      return a_old < b_old
    end
    if a_recency == nil then
      return false
    end
    if b_recency == nil then
      return true
    end
    return b_recency < a_recency
  end)
  pickers.new(opts, {
    prompt_title = "Recent files",
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts)
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
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
    },
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local dir = get_workspace_dir(selection[1]) .. "/google3"
        vim.cmd("cd " .. dir)
      end)
      return true
    end
  }):find()
end

return M
