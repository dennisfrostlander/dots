vim.cmd("set runtimepath+=~/projects/neovim-dots/")

require("plugins")

require("utils.lua")
require("web-devicons.lua")

require("general")
require("editing")
require("lua_lsp")
require("telescope-config")
require("completion")

-- lsp
require("nvim-lspconfig.lua")

require("gitsigns.lua")
require("file_search")

require"colorizer".setup()

require("treesitter.lua")
require("mappings.lua")

-- highlights
-- cmd("hi LineNr guibg=NONE")
-- cmd("hi SignColumn guibg=NONE")
-- cmd("hi VertSplit guibg=NONE")
-- cmd("hi DiffAdd guifg=#81A1C1 guibg = none")
-- cmd("hi DiffChange guifg =#3A3E44 guibg = none")
-- cmd("hi DiffModified guifg = #81A1C1 guibg = none")
-- cmd("hi EndOfBuffer guifg=#282c34")
--
-- cmd("hi TelescopeBorder   guifg=#3e4451")
-- cmd("hi TelescopePromptBorder   guifg=#3e4451")
-- cmd("hi TelescopeResultsBorder  guifg=#3e4451")
-- cmd("hi TelescopePreviewBorder  guifg=#525865")
-- cmd("hi PmenuSel  guibg=#98c379")
--
-- -- tree folder name , icon color
-- cmd("hi NvimTreeFolderIcon guifg = #61afef")
-- cmd("hi NvimTreeFolderName guifg = #61afef")
-- cmd("hi NvimTreeIndentMarker guifg=#545862")

require("nvim-autopairs").setup()

