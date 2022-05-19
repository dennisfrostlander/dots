local M = {}

M.unquote = function(s)
  local res = string.gsub(s, '"(.+)"', "%1")
  return res
end

return M
