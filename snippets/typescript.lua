local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

print("typescript snippets")
return {
  s("af", fmt([[({}) => {{
  {}
}}]], {i(1), i(0)}))
}, nil
