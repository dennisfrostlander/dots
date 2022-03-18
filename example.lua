vim.cmd("set runtimepath+=~/projects/neovim-dots/")

require("main")

local workspace = require("workspace")
workspace.setup({
  "/Users/frostlander/projects/neovim-dots",
})

