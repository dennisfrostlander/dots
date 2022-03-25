local utils = require("utils")
local M = {}

local workspace_dirs

local function stat(filename)
  local s = vim.loop.fs_stat(filename)
  if not s then
    return nil
  end
  return s.type
end

local function get_dirs()
  if workspace_dirs then
    return workspace_dirs
  end
  workspace_dirs = {}
  for _,arg in ipairs(vim.v.argv) do
    local s = stat(arg)
    if s == "directory" then
      table.insert(workspace_dirs, arg)
    elseif s == "file" then
      table.insert(workspace_dirs, utils.dirname(arg))
    end
  end
  if table.getn(workspace_dirs) == 0 then
    table.insert(workspace_dirs, vim.fn.getcwd())
  end
  return workspace_dirs
end

M.setup = function(dirs)
  workspace_dirs = dirs
end

M.get_workspace_dirs = function()
  return get_dirs()
end

M.get_relative_workspace_dirs = function()
  local dirs = get_dirs()
  local reldirs = {}
  for _,p in ipairs(dirs) do
    table.insert(reldirs, vim.fn.fnamemodify(vim.fn.expand(p), ":."))
  end
  return reldirs
end

return M;
