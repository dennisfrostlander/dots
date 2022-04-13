local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function copy(args)
  return args[1]
end

return {
  s("cctest", fmt([[cc_test(
    name = "{}",
    srcs = ["{}.cc"],
    deps = [
      "{}"
    ],
  )]], {i(1), f(copy, 1), i(0)})), --
  s("cclib", fmt([[cc_library(
    name = "{}",
    hdrs = ["{}.h"],
    srcs = ["{}.cc"],
    deps = [
      "{}"
    ],
  )]], {i(1), f(copy, 1), f(copy, 1), i(0)})), --
}, nil
