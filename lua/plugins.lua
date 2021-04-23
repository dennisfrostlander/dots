pcall(vim.cmd, [[packadd packer.nvim]])
-- check if packer is installed (~/local/share/nvim/site/pack)
return require("packer").startup(
    function(use)
        use {"wbthomason/packer.nvim", opt = true}
        use {"famiu/nvim-reload"}

        -- use {"dracula/vim"}
        -- use {"morhetz/gruvbox"}
        use {"arcticicestudio/nord-vim"}
        -- use {"fenetikm/falcon"}

        use {"nvim-lua/popup.nvim"}
        use {"nvim-lua/plenary.nvim"}
        use {"voldikss/vim-floaterm"}
        use {
          'hoob3rt/lualine.nvim',
          config = function()
            require('lualine').setup{
              options = {theme = 'nord'}
            }
          end
        }
        use {"norcalli/nvim-colorizer.lua"}
        use {"kyazdani42/nvim-web-devicons"}

        use {"mhinz/vim-startify"}
        use {"lewis6991/gitsigns.nvim"}
        use {"christoomey/vim-tmux-navigator"}
        use {"rmagatti/auto-session"}

        use {"tpope/vim-surround"}
        use {"tpope/vim-commentary"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"hrsh7th/vim-vsnip"}
        use {"ntpeters/vim-better-whitespace"}
        use {"stefandtw/quickfix-reflector.vim"}

        use {"neovim/nvim-lspconfig"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'}
        use {"hrsh7th/nvim-compe"}
        use {"nvim-lua/completion-nvim"}
        use {"sbdchd/neoformat"}

        use {"nvim-telescope/telescope.nvim"}
        use {"ptzz/lf.vim"}

        use {"tweekmonster/startuptime.vim"}
    end
)
