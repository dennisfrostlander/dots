-- Colorscheme + custom overrides.
vim.cmd[[
colorscheme nord

hi! link TSType Function
hi! link TSVariableBuiltin Keyword
hi! link TSBoolean Keyword
hi! link TSConstructor Function
hi! TSFunction gui=italic guifg=#88C0D0
hi! TSParameter gui=italic guifg=#D8DEE9
hi nCursor guibg=white
hi Comment guifg=#7b88a1

hi LspSignatureActiveParameter gui=underline

hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=NONE
hi SignColumn guibg=NONE
hi VertSplit guibg=NONE
]]

