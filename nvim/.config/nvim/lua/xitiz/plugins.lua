local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = " "

-- require("lazy").setup("xitiz.plugins")
require("lazy").setup(
    {
        -- Packer can manage itself
        { 'nvim-lua/popup.nvim' },

        -- Navigation
        {
            'nvim-telescope/telescope.nvim', version = false,
            -- or                            , branch = '0.1.x',
            dependencies = { { 'nvim-lua/plenary.nvim' } },

        },
        { 'nvim-telescope/telescope-fzf-native.nvim',   build = 'make',                         after = 'nvim-telescope/telescope.nvim' },
        { "nvim-telescope/telescope-file-browser.nvim", after = 'nvim-telescope/telescope.nvim' },

        {
            'kyazdani42/nvim-tree.lua',

        },
        -- colorscheme
        { 'folke/tokyonight.nvim' },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',

        },
        -- { 'JoosepAlviste/nvim-ts-context-commentstring' },
        {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup({}) end,
            after = { 'nvim-treesitter/nvim-treesitter' },
        },
        {
            'windwp/nvim-ts-autotag',
            after = { 'nvim-treesitter/nvim-treesitter' },
        },

        -- Git
        { 'tpope/vim-fugitive', },
        {
            'lewis6991/gitsigns.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },

        },
        { 'junegunn/gv.vim',                     dependencies = { 'tpope/vim-fugitive' }, },
        { 'sindrets/diffview.nvim',              dependencies = 'nvim-lua/plenary.nvim', },

        -- LSP
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim',     dependencies = { "mason.nvim" } },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp', },
        { 'hrsh7th/cmp-buffer',                  after = { 'hrsh7th/nvim-cmp' } },
        { 'hrsh7th/cmp-path',                    after = { 'hrsh7th/nvim-cmp' } },
        { 'saadparwaiz1/cmp_luasnip',            after = { 'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip' } },
        { 'hrsh7th/cmp-nvim-lsp',                after = { 'hrsh7th/nvim-cmp' } },
        { 'hrsh7th/cmp-nvim-lua',                after = { 'hrsh7th/nvim-cmp' } },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = { 'hrsh7th/nvim-cmp' } },

        -- Snippets
        { 'L3MON4D3/LuaSnip', },
        { 'rafamadriz/friendly-snippets', },

        -- Movements and quality of life
        { 'mbbill/undotree' },
        { 'phaazon/hop.nvim' },
        {
            'numToStr/Comment.nvim',

            config = function()
                require('Comment').setup({})
            end
        },
        {
            "kylechui/nvim-surround",

            version = "*", -- Use for stability; omit to  `main` branch for the latest features
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to  defaults
                })
            end
        },
        { 'gpanders/editorconfig.nvim', },
        { 'lukas-reineke/indent-blankline.nvim', },
        { 'nvim-lualine/lualine.nvim', },
        { 'nvim-tree/nvim-web-devicons', },

        {
            "utilyre/barbecue.nvim",

            version = "*",
            dependencies = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons", -- optional dependency
            },
            after = "nvim-web-devicons",
        },
        -- tmux
        { 'tmux-plugins/vim-tmux-focus-events' },
        { 'christoomey/vim-tmux-navigator' },

        -- Debug Adapter Protocol
        { 'mfussenegger/nvim-dap', },
        { 'rcarriga/nvim-dap-ui',              dependencies = 'mfussenegger/nvim-dap', },
        { 'nvim-telescope/telescope-dap.nvim' },
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup({})
            end
        },

        {
            'simrat39/symbols-outline.nvim',

            config = function()
                require("symbols-outline").setup()
            end
        },

        -- TODO: neogen package
    })
