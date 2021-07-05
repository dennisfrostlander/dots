vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd nvim-compe]]

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {noremap = true, silent = true}

-- Mappings.
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- map("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
-- map("n", "<Leader>wl",
--     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
-- --     opts)
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
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
capabilities.workspace.configuration = true
capabilities.workspace.didChangeConfiguration = {}
capabilities.workspace.didChangeConfiguration.dynamicRegistration = true

require("lspconfig").tsserver.setup {
  capabilities = capabilities,
  on_init = function(client)
    local settings = {}
    settings["typescript.preferences.importModuleSpecifier"] = "relative"
    client.notify("workspace/didChangeConfiguration", {settings = settings})
    return true
  end,
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {}
    ts_utils.setup_client(client)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rf", ":TSLspRenameFile<CR>", {silent = true})
  end
}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}

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

-- require("lsp_signature").on_attach()

-- local saga = require("lspsaga")
-- saga.init_lsp_saga({
--  use_saga_diagnostic_sign = false
-- })

-- map("n", "<Leader>rn", ":Lspsaga rename<CR>", opts)
