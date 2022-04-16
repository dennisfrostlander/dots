local recent_bufs = {}
local cnt = 0

_G.recents_buf_enter = function()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  if current_file then
    recent_bufs[current_file] = cnt
    cnt = cnt + 1
  end
end

_G.print_bufs = function()
  local keys = {}
  for key, _ in pairs(recent_bufs) do table.insert(keys, key) end
  table.sort(keys, function(a, b) return recent_bufs[a] < recent_bufs[b] end)
  for _, key in ipairs(keys) do print(key, recent_bufs[key]) end
end

vim.cmd [[
augroup bufs
  au!
  au! BufEnter * lua recents_buf_enter(123)
augroup END
]]

local M = {}

