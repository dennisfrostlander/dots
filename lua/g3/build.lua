local path = require "plenary.path"
local ts_utils = require 'nvim-treesitter.ts_utils'
local ts = require "g3.ts"
local strings = require "g3.strings"
local M = {}

M.get_rule_attr = function(node, attr)
  assert(node:type() == "expression_statement", node:type())
  local arglist = ts.find_child_by_type(node, "argument_list")
  assert(arglist, node:type())
  local args = ts.find_children_by_type(arglist, "keyword_argument")
  for _, arg in ipairs(args) do
    local name_node = ts.get_single_child_by_field(arg, "name")
    if vim.treesitter.query.get_node_text(name_node, 0) == attr then
      return ts.get_single_child_by_field(arg, "value")
    end
  end
  return nil
end

M.rule_has_file = function(node, file)
  local srcs = M.get_rule_attr(node, "srcs")
  if srcs and ts.find_in_string_list(srcs, file) then
    return true
  end
  local hdrs = M.get_rule_attr(node, "hdrs")
  if hdrs and ts.find_in_string_list(hdrs, file) then
    return true
  end
  return false
end

M.get_rule_name = function(node)
  local name_node = M.get_rule_attr(node, "name")
  local name = vim.treesitter.query.get_node_text(name_node, 0)
  return strings.unquote(name)
end

M.get_build_file_path = function(file)
  file = file or vim.api.nvim_buf_get_name(0)
  local p = path.new(file)
  return p:parent():joinpath("BUILD").filename
end

M.goto_build_rule = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local p = path.new(current_file)
  local basename = p:make_relative(p:parent().filename)
  vim.cmd("e " .. M.get_build_file_path())
  local parser = vim.treesitter.get_parser(0, "python")
  local tree = parser:parse()
  local root = tree[1]:root()
  local query = vim.treesitter.parse_query("python", "(expression_statement) @k")
  for _, node in query:iter_captures(root, 0, root:start(), root:end_()) do
    if M.rule_has_file(node, basename) then
      ts_utils.goto_node(node)
    end
  end
end

return M
