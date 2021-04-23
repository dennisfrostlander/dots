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

map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<Leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts)
map("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
map("n", "<Leader>k", [[<cmd> lua vim.lsp.buf.formatting_sync()<CR>]], opts)

vim.cmd([[
autocmd FileType help nmap <buffer> gd <C-]>
]])

local function rename_file()
  local file = vim.fn["input"]({prompt = "> ", default = vim.fn["expand"]("%:p")})
  local params = {
    command = "_typescript.applyRenameFile",
    arguments = {sourceUri = vim.uri_from_fname(file), targetUri = vim.uri_from_fname(file .. "1")},
    title = ""
  }
  print(vim.inspect(params))
  vim.lsp.buf.execute_command(params)
end

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

require("lspconfig").tsserver.setup {
 commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    },
    RenameFile = {
      rename_file,
      description = "Rename file"
    },
     LspRenameFile = {
      function()
        vim.call('inputsave')

        local current = vim.api.nvim_buf_get_name(0)
        local rename = vim.fn.input('Set the path to rename to' .. ' ➜ ', current)

        vim.api.nvim_command('normal :esc<CR>')

        vim.api.nvim_out_write(current .. ' ➜ ' .. rename .. '\n')

        vim.lsp.buf.execute_command({command = '_typescript.applyRenameFile', arguments = {{sourceUri = 'file://' .. current, targetUri = 'file://' .. rename}}, title = ''})

        vim.loop.fs_rename(current, rename)

        for _, buf in pairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            if vim.api.nvim_buf_get_name(buf) == current then
              vim.api.nvim_buf_set_name(buf, rename)
              -- to avoid the 'overwrite existing file' error message on write
              vim.api.nvim_buf_call(buf, function()
                vim.cmd('silent! w!')
              end)
            end
          end
        end

        vim.call('inputrestore')
      end
    }
  }
}
require("lspconfig").cssls.setup {}
require("lspconfig").html.setup {}
require("lspconfig").angularls.setup {}

require("lspkind").init({File = "Ôêì "})
