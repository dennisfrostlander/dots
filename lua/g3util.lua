local ts_utils = require 'nvim-treesitter.ts_utils'
local path = require 'plenary.path'
local bufnr = 713

local function unquote(s)
  local res = string.gsub(s, '"(.+)"', "%1")
  return res
end

local function find_children_by_type(node, child_type)
  local result = {}
  for i = 0, node:child_count() - 1 do
    local child = node:child(i)
    if child:type() == child_type then
      table.insert(result, child)
    end
  end
  return result
end

local function find_child_by_type(node, child_type)
  for i = 0, node:child_count() - 1 do
    local child = node:child(i)
    if child:type() == child_type then
      return child
    end
    local res = find_child_by_type(child, child_type)
    if res then
      return res
    end
  end
  return nil
end

local function get_single_child_by_field(node, field)
  local children = node:field(field)
  if #children == 0 then
    return nil
  end
  assert(#children == 1, "Expected a single key in node " .. node:type() ..
    ", but found " .. #children)
  return children[1]
end

local function get_rule_attr(node, attr)
  assert(node:type() == "expression_statement", node:type())
  local arglist = find_child_by_type(node, "argument_list")
  assert(arglist, node:type())
  local args = find_children_by_type(arglist, "keyword_argument")
  for _, arg in ipairs(args) do
    local name_node = get_single_child_by_field(arg, "name")
    if vim.treesitter.query.get_node_text(name_node, bufnr) == attr then
      return get_single_child_by_field(arg, "value")
    end
  end
  return nil
end

local function rule_has_file(node, file)
  local srcs = get_rule_attr(node, "srcs")
  assert(srcs:type() == "list", srcs:type())
  local srcs_values = find_children_by_type(srcs, "string")
  for _, value in ipairs(srcs_values) do
    local src = vim.treesitter.query.get_node_text(value, bufnr)
    if unquote(src) == file then
      return true
    end
  end
  return false
end

local function get_rule_name(node)
  local name_node = get_rule_attr(node, "name")
  local name = vim.treesitter.query.get_node_text(name_node, bufnr)
  return unquote(name)
end

function g()
  local current_file = vim.api.nvim_buf_get_name(0)
  local p = path.new(current_file)
  print(p:parent())
  return ""
  -- local parser = vim.treesitter.get_parser(bufnr, "python")
  -- local tree = parser:parse()
  -- local root = tree[1]:root()
  -- local query = vim.treesitter
  --                 .parse_query("python", "(expression_statement) @k")
  -- for id, node in query:iter_captures(root, bufnr, root:start(), root:end_()) do
  --   if rule_has_file(node, ".cc") then
  --     vim.cmd("e " .. "/tmp/test.py")
  --     ts_utils.goto_node(node)
  --   end
  -- end
end

g()
