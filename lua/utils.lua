local M = {}

local is_win = vim.loop.os_uname().sysname == "Windows"
local path_sep = is_win and "\\" or "/"

M.dirname = function(filepath)
  local result = filepath:gsub(path_sep.."([^"..path_sep.."]+)$", function()
    return ""
  end)
  return result
end

M.config_dir_path = function()
  local str = debug.getinfo(2, 'S').source:sub(2)
  if is_win then
    str = str:gsub('/', '\\')
  end
  local path = str:match('(.*' .. path_sep .. ')')
  return M.dirname(path) .. "/.."
end

return M
