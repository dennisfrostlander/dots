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

return M;
