require('formatter').setup({
  filetype = {
    lua = {
      function()
        return {
          exe = "lua-format",
          args = {
            "--indent-width", 2, "--continuation-indent-width", 2,
            "--no-align-args"
          },
          stdin = true
        }
      end
    },
    html = {
      function()
        return {
          exe = "js-beautify",
          args = {
            "--type", "html", "--indent-size", 2, "--preserve-newlines",
            "--wrap-attributes", "aligned-multiple", "--wrap-line-length", 80
          },
          stdin = true
        }
      end
    },
    json = {
      function()
        return {exe = "js-beautify", args = {"--type", "js"}, stdin = true}
      end
    }
  }
})

vim.api.nvim_exec([[
augroup format
  au!
  au FileType html,json,lua nnoremap <buffer> <Leader>k :FormatWrite<CR>
  au FileType scss nnoremap <buffer> <Leader>k gg=G<C-O>
augroup END
]], false)
