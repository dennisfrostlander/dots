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

local function copy(args)
  return args[1]
end

return {
  -- types
  s("csr", t("const std::string& ")), --
  s("sv", t("absl::string_view ")), --
  s("up", fmt("std::unique_ptr<{}> {}", {i(1), i(0)})),
  s("mku", fmt("absl::make_unique<{}>({})", {i(1), i(0)})),
  -- flags
  s("df", fmt("ABSL_FLAG({type}, {name}, {default}, {desc});{e}",
    {type = i(1), name = i(2), default = i(3), desc = i(4), e = i(0)})),
  s("gf", fmt("absl::GetFlag(FLAGS_{name}){e}", {name = i(1), e = i(0)})),
  s("sf", fmt("absl::SetFlag(&FLAGS_{name}, {val}){e}",
    {name = i(1), val = i(2), e = i(0)})), --
  s("ok", t("absl::OkStatus()")), --
  -- status and macros
  s("st", t("absl::Status")), --
  s("stor", fmt("absl::StatusOr<{t}>{e}", {t = i(1), e = i(0)})), --
  s("aor", fmt("ASSIGN_OR_RETURN({}, {});{}", {i(1), i(2), i(0)})), --
  s("rie", fmt("RETURN_IF_ERROR({});{}", {i(1), i(0)})), --
  -- logs
  s("li", fmt([[LOG(INFO) << "{}";{}]], {i(1), i(0)})), --
  s("le", fmt([[LOG(ERROR) << "{}";{}]], {i(1), i(0)})), --
  s("lv", fmt([[VLOG(4) << "{}";{}]], {i(1), i(0)})), --
  s("ld", fmt([[LOG(ERROR) << "frost: " << "{}";{}]], {i(1), i(0)})), --
  -- testing
  s("tm", fmt([[TEST_F({}, {}) {{
    {}
}}]], {i(1), i(2), i(0)})), --
  -- build
  s("cctest", fmt([[cc_test(
    name = "{}",
    srcs = [{}.cc],
    deps = [
      "{}"
    ],
  )]], {i(1), f(copy, 1), i(0)})), --
  -- other
  s("todo", fmt("// TODO(b/{}): {}", {i(1), i(0)})), --
  s("na", fmt("/*{}=*/{}", {i(1), i(0)})), --
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
