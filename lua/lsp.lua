vim.cmd [[packadd nvim-lspconfig]]

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {noremap = true}

-- Mappings.
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- map("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wl",
--     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
-- -- --     opts)
-- map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>k", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)

vim.cmd([[
autocmd FileType help nmap <buffer> gd <C-]>
]])

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
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "single"
      },
      hint_enable = false,
      floating_window = true,
      fix_pos = true,
    }, bufnr)
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

map("n", "<Leader>ri", ":TSLspOrganizeSync<CR>", {silent = true})

USER = vim.fn.expand('$USER')

-- local sumneko_root_path = ""
-- local sumneko_binary = ""
-- if vim.fn.has("mac") == 1 then
--   sumneko_root_path = "/Users/" .. USER .. "/projects/lua-language-server"
--   sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
-- else
--   print("Unsupported system for sumneko")
-- end
-- require("lspconfig").sumneko_lua.setup {
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = vim.split(package.path, ';'),
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--           [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--         },
--       },
--     },
--   },
-- }
-- require("lspconfig").efm.setup {
--     init_options = {documentFormatting = true},
--     filetypes = {"lua"},
--     settings = {
--         rootMarkers = {".git/"},
--         languages = {
--             lua = {
--                 {
--                     formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
--                     formatStdin = true
--                 }
--             }
--         }
--     }
-- }

-- local project_library_path = "/Users/frostlander/.nvm/versions/node/v12.18.4/lib/node_modules"
-- local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}
-- require("lspconfig").angularls.setup {
--   capabilities = capabilities,
  -- cmd = cmd,
  -- on_new_config = function(new_config,new_root_dir)
  --   new_config.cmd = cmd
  -- end,
-- }

require("lspkind").init({File = "Ôêì "})

local saga = require("lspsaga")
saga.init_lsp_saga({
 use_saga_diagnostic_sign = false,
 code_action_icon = '',
})

map("n", "<Leader>rn", ":Lspsaga rename<CR>", opts)
map("n", "<Leader>j", ":Lspsaga code_action<CR>", opts)
map("v", "<Leader>j", ":Lspsaga range_code_action<CR>", opts)

map("n", "K", ":Lspsaga hover_doc<CR>", opts)
map("n", "<C-g>", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
map("i", "<C-g>", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
-- map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
-- map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

require("trouble").setup {
}
map("n", "<Leader>vd", ":TroubleToggle lsp_workspace_diagnostics<CR>", opts)
