vim.cmd [[packadd nvim-lspconfig]]

-- Uncomment for debugging: lua vim.cmd('tabe'..vim.lsp.get_log_path())
-- vim.lsp.set_log_level("debug")

local function setup_document_highlight()
  vim.cmd[[
  augroup doc_highlight
    au! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  augroup
  ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require("lspconfig").tsserver.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {}
    ts_utils.setup_client(client)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rf", ":TSLspRenameFile<CR>", {silent = true})
    setup_document_highlight()
  end,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative"
    }
  }
}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}

-- Add a CiderLSP configuration.
local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')
configs.ciderlsp = {
 default_config = {
   cmd = {'/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp' , '--noforward_sync_responses'};
   filetypes = {'c', 'cpp', 'java', 'proto', 'textproto', 'go', 'python', 'bzl', 'sql', 'gcl', 'markdown'};
   root_dir = nvim_lsp.util.root_pattern('BUILD');
   settings = {};
 }
}

-- Setup CiderLSP.
nvim_lsp.ciderlsp.setup{
  on_attach = function(client, bufnr)
    -- Omni-completion via LSP. See `:help compl-omni`. Use <C-x><C-o> in
    -- insert mode. Or use an external autocompleter (see below) for a
    -- smoother UX.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
    end
    if vim.lsp.tagfunc then -- Neovim v0.6.0+ only.
      -- Tag functionality via LSP. See `:help tag-commands`. Use <c-]> to
      -- go-to-definition.
      vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end
    setup_document_highlight()
  end
}

-- Lua language server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "single"
  },
  hint_enable = false,
  floating_window = true,
  fix_pos = true,
  toggle_key = "<C-k>"
})

require("trouble").setup()

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {noremap = true}

-- Mappings.
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- map("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wl",
--     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
-- -- --     opts)
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<Leader>ri", ":TSLspOrganizeSync<CR>", {silent = true})
map("n", "<Leader>j", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("v", "<Leader>j", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

map("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)

map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>k", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)

vim.cmd([[
autocmd FileType help nmap <buffer> gd <C-]>
]])
map("n", "<Leader>vd", ":TroubleToggle lsp_workspace_diagnostics<CR>", opts)

