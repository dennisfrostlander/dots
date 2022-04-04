local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_header_def()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local _, start_index = current_file:find("/google3/")
  local result = current_file:sub(start_index + 1)
  result = result:upper()
  result = result:gsub("%W", "_")
  return result .. "_"
end

return {
  s("up", fmt("std::unique_ptr<{}> {}", {i(1), i(0)})),
  s("df", fmt("ABSL_FLAG({type}, {name}, {default}, {desc});{e}",
    {type = i(1), name = i(2), default = i(3), desc = i(4), e = i(0)})),
  s("gf", fmt("absl::GetFlag(FLAGS_{name}){e}", {name = i(1), e = i(0)})),
  s("sf", fmt("absl::SetFlag(&FLAGS_{name}, {val}){e}",
    {name = i(1), val = i(2), e = i(0)})), --
  s("ok", t("absl::OkStatus()")), --
  s("once", {
    f(function()
      local def = get_header_def()
      return {"#ifndef " .. def, "#define " .. def, "", ""}
    end), i(0), f(function()
      local def = get_header_def()
      return {"", "", "#endif  // " .. def}
    end)
  })
}, nil
