local strings = require "g3.strings"
local M = {}

M.find_children_by_type = function(node, child_type)
  local result = {}
  for i = 0, node:child_count() - 1 do
    local child = node:child(i)
    if child:type() == child_type then
      table.insert(result, child)
    end
  end
  return result
end

M.find_child_by_type = function(node, child_type)
  for i = 0, node:child_count() - 1 do
    local child = node:child(i)
    if child:type() == child_type then
      return child
    end
    local res = M.find_child_by_type(child, child_type)
    if res then
      return res
    end
  end
  return nil
end

M.get_single_child_by_field = function(node, field)
  local children = node:field(field)
  if #children == 0 then
    return nil
  end
  assert(#children == 1, "Expected a single key in node " .. node:type() ..
    ", but found " .. #children)
  return children[1]
end

M.find_in_string_list = function(node, needle)
  assert(node:type() == "list", node:type())
  local values = M.find_children_by_type(node, "string")
  for _, value in ipairs(values) do
    local v = vim.treesitter.query.get_node_text(value, 0)
    if strings.unquote(v) == needle then
      return true
    end
  end
  return false
end

return M
