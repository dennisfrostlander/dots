local path = require "plenary.path"
local ts_utils = require "nvim-treesitter.ts_utils"
local bufnr = 1231

local function get_captured_node(query, match, capture_name)
  for id, node in pairs(match) do
    if query.captures[id] == capture_name then
      return node
    end
  end
  return nil
end

local function get_captured_node_text(query, match, capture_name)
  local node = get_captured_node(query, match, capture_name)
  if not node then
    error("Could not find captured node " .. capture_name)
  end
  local lines = ts_utils.get_node_text(node, bufnr)
  return table.concat(lines, "\n")
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require"telescope.config".values
local entry_display = require "telescope.pickers.entry_display"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

local function gen_entry(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local display_items = {
    {width = opts.symbol_width or 25}, -- symbol
    {width = opts.symbol_type_width or 8}, -- symbol type
    {remaining = true} -- filename{:optional_lnum+col} OR content preview
  }

  local displayer = entry_display.create {
    separator = " ",
    hl_chars = {["["] = "TelescopeBorder", ["]"] = "TelescopeBorder"},
    items = display_items
  }

  local make_display = function(entry)
    local msg

    -- what to show in the last column: filename or symbol information
    if opts.ignore_filename then -- ignore the filename and show line preview instead
      -- TODO: fixme - if ignore_filename is set for workspace, bufnr will be incorrect
      msg =
        vim.api.nvim_buf_get_lines(bufnr, entry.lnum - 1, entry.lnum, false)[1] or
          ""
      msg = vim.trim(msg)
    else
      local filename = utils.transform_path(opts, entry.filename)

      if opts.show_line then -- show inline line info
        filename = filename .. " [" .. entry.lnum .. ":" .. entry.col .. "]"
      end
      msg = filename
    end

    local display_columns = {entry.symbol_name, entry.symbol_type:lower(), msg}

    if opts.ignore_filename and opts.show_line then
      table.insert(display_columns, 2,
        {entry.lnum .. ":" .. entry.col, "TelescopeResultsLineNr"})
    end

    return displayer(display_columns)
  end

  return function(entry)
    local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)
    local symbol_msg = entry.text
    local symbol_name = entry.symbol_name

    local ordinal = ""
    if not opts.ignore_filename and filename then
      ordinal = filename .. " "
    end
    ordinal = ordinal .. symbol_name .. " " .. ("st" or "unknown")
    return {
      valid = true,

      value = entry,
      ordinal = ordinal,
      display = make_display,

      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      symbol_name = symbol_name,
      symbol_type = "st",
      start = entry.start,
      finish = entry.finish
    }
  end
end

local function cursor_lsp_range()
  local r, c = unpack(vim.api.nvim_win_get_cursor(0))
  local range = {}
  range.start = {line = r - 1, character = c - 1}
  range["end"] = {line = r - 1, character = c - 1}
  return range
end

function goto_build_rule()
  local insert_range = cursor_lsp_range()
  local current_file = vim.api.nvim_buf_get_name(0)
  local p = path.new(current_file)
  local parser = vim.treesitter.get_parser(bufnr, "cpp")
  local tree = parser:parse()
  local root = tree[1]:root()
  local query = vim.treesitter.parse_query("cpp", [[
  (class_specifier
    name: (type_identifier) @class_name
    body: (field_declaration_list
      (field_declaration
        declarator: (function_declarator
          declarator: (field_identifier) @func_name
        ) @fun
      ) @signature
    )
  )
  ]])
  local results = {}
  for _, match in query:iter_matches(root, bufnr, root:start(), root:end_()) do
    local signature_node = get_captured_node(query, match, "signature")
    local signature = get_captured_node_text(query, match, "signature")
    local class_name = get_captured_node_text(query, match, "class_name")
    local func_name = get_captured_node_text(query, match, "func_name")
    signature = signature:gsub(func_name, class_name .. "::" .. func_name)
    signature = signature:gsub(";", " {\n\n}")
    local l, c = signature_node:start()
    local entry = {}
    entry.bufnr = bufnr
    entry.text = signature:gsub("\n", " ")
    -- entry.filename = "/tmp/1.h"
    entry.lnum = l + 1
    entry.col = c + 1
    entry.symbol_name = func_name
    entry.signature = signature
    table.insert(results, entry)
  end

  local function select(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    print(vim.inspect(entry))
    local edit = {}
    edit.range = insert_range
    edit.newText = entry.value.signature
    local edits = {}
    table.insert(edits, edit)
    print(vim.inspect(edits))
    vim.lsp.util.apply_text_edits(edits, bufnr)
    actions.close(prompt_bufnr)
  end

  local opts = {
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<CR>", select)
      return true
    end
  }
  pickers.new(opts, {
    prompt_title = "Select declaration",
    finder = finders.new_table {
      results = results,
      entry_maker = make_entry.gen_from_quickfix()
    },
    sorter = conf.generic_sorter(opts),
    previewer = conf.qflist_previewer(opts)
  }):find()
end

goto_build_rule()
