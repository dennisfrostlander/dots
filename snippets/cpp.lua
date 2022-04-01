local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

local function get_header_def()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local _, start_index = current_file:find("/google3/")
  local result = current_file:sub(start_index + 1)
  result = result:upper()
  result = result:gsub("%W", "_")
  return result.."_"
end

return {
  s("ok", {
    t("absl::OkStatus()"),
  }),
  s("once", {
    f(function()
      local def = get_header_def()
      return {
        "#ifndef " .. def,
        "#define " .. def,
        "",
        "",
      }
    end),
    i(0),
    f(function()
      local def = get_header_def()
      return {
        "",
        "",
        "#endif  // " .. def
      }
    end),
  }),
}, nil
