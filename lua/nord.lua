-- Colorscheme + custom overrides.
vim.cmd[[
colorscheme nord

hi Nord0 guifg=#2E3440
hi Nord1 guifg=#3B4252
hi Nord2 guifg=#434C5E
hi Nord3 guifg=#4C566A
hi Nord4 guifg=#D8DEE9
hi Nord5 guifg=#E5E9F0
hi Nord6 guifg=#ECEFF4
hi Nord7 guifg=#8FBCBB
hi Nord8 guifg=#88C0D0
hi Nord9 guifg=#81A1C1
hi Nord10 guifg=#5E81AC
hi Nord11 guifg=#BF616A
hi Nord12 guifg=#D08770
hi Nord13 guifg=#EBCB8B
hi Nord14 guifg=#A3BE8C
hi Nord15 guifg=#B48EAD

hi Comment guifg=#7b88a1
hi CommentItalic guifg=#7b88a1 gui=italic

hi! link TSType Nord8
hi! link TSNamespace TSKeyword
hi! link TSConstant Nord15
hi! link TSVariableBuiltin Keyword
hi! link TSBoolean Keyword
hi! link TSConstructor TSFunction

hi! link sdlStatement TSKeyword

hi! TSParameter gui=italic
hi! clear TSVariable

hi! link LogInfo Nord9
hi! link LogWarn Nord13
hi! link LogError Nord11
hi! link LogFatal Nord15

hi nCursor guibg=white

hi LspSignatureActiveParameter gui=underline

hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=NONE
hi SignColumn guibg=NONE
hi VertSplit guibg=NONE

hi! link FloatTitle Nord13

" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#4C566A
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#81A1C1
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#81A1C1
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#88C0D0
highlight! CmpItemKindInterface guibg=NONE guifg=#88C0D0
highlight! CmpItemKindText guibg=NONE guifg=#88C0D0
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#B48EAD
highlight! CmpItemKindMethod guibg=NONE guifg=#B48EAD
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D8DEE9
highlight! CmpItemKindProperty guibg=NONE guifg=#D8DEE9
highlight! CmpItemKindUnit guibg=NONE guifg=#D8DEE9
]]

