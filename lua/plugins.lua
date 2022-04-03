pcall(vim.cmd, [[packadd packer.nvim]])
-- check if packer is installed (~/local/share/nvim/site/pack)
return require("packer").startup(
    function(use)
        use {"wbthomason/packer.nvim", opt = true}

        -- use {"dracula/vim"}
        -- use {"morhetz/gruvbox"}
        use {"arcticicestudio/nord-vim"}
        -- use {"dennisfrostlander/nord-vim", branch = "master"}
        -- use 'shaunsingh/nord.nvim'
        -- use { "shaunsingh/nord.nvim" }
        -- use {"fenetikm/falcon"}
        -- use {"folke/tokyonight.nvim"}

        use {"nvim-lua/popup.nvim"}
        use {"nvim-lua/plenary.nvim"}
        use {"voldikss/vim-floaterm"}
        use {"hoob3rt/lualine.nvim"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"kyazdani42/nvim-web-devicons"}
        use {"lukas-reineke/indent-blankline.nvim"}
        use {"stevearc/dressing.nvim"}

        use {"tpope/vim-fugitive"}
        use {"lewis6991/gitsigns.nvim"}
        use {"mhinz/vim-signify"}
        use {"sindrets/diffview.nvim"}
        use {"christoomey/vim-tmux-navigator"}

        use {"tpope/vim-surround"}
        use {"numToStr/Comment.nvim"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"L3MON4D3/LuaSnip"}
        use {"rafamadriz/friendly-snippets"}
        use {"ntpeters/vim-better-whitespace"}
        use {"stefandtw/quickfix-reflector.vim"}

        use {"neovim/nvim-lspconfig"}
        use {"onsails/lspkind-nvim"}
        use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate'}
        use {"nvim-treesitter/playground"}
        use {"hrsh7th/cmp-nvim-lsp"}
        use {"hrsh7th/cmp-buffer"}
        use {"hrsh7th/nvim-cmp"}
        use {"f3fora/cmp-spell"}
        use {"hrsh7th/cmp-path"}
        use {"saadparwaiz1/cmp_luasnip"}
        use {"jose-elias-alvarez/nvim-lsp-ts-utils"}
        use {"ray-x/lsp_signature.nvim"}
        use {"sbdchd/neoformat"}
        use {"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }

        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make' }
        use {"ptzz/lf.vim"}

        use {"tweekmonster/startuptime.vim"}

        use {"sso://googler@user/vintharas/telescope-codesearch.nvim"}
    end
)
