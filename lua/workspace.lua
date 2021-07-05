local M = {}
local workspace_dirs

M.setup = function(dirs)
  workspace_dirs = dirs
end

M.get_workspace_dirs = function()
  if not workspace_dirs then
    return {vim.env.PWD}
  end
  return workspace_dirs
end

M.get_relative_workspace_dirs = function()
  local reldirs = {}
  for i,p in ipairs(workspace_dirs) do
    table.insert(reldirs, vim.fn.fnamemodify(vim.fn.expand(p), ":."))
  end
  return reldirs
end

return M;
