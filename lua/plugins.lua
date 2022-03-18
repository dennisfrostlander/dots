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

        use {"lewis6991/gitsigns.nvim"}
        use {"mhinz/vim-signify"}
        use {"sindrets/diffview.nvim"}
        use {"christoomey/vim-tmux-navigator"}
        use {"rmagatti/auto-session"}

        use {"tpope/vim-surround"}
        use {"tpope/vim-commentary"}
        use {"windwp/nvim-autopairs"}
        use {"alvan/vim-closetag"}
        use {"hrsh7th/vim-vsnip"}
        use {"hrsh7th/vim-vsnip-integ"}
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
        use {"hrsh7th/cmp-vsnip"}
        use {"f3fora/cmp-spell"}
        use {"hrsh7th/cmp-path"}
        use {"jose-elias-alvarez/nvim-lsp-ts-utils"}
        -- Temp fix for code actions in nvim 0.5.1
        use {"rinx/lspsaga.nvim"}
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
