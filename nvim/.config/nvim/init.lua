-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-commentary'
    use 'kyazdani42/nvim-tree.lua'

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-media-files.nvim', requires = { 'nvim-telescope/telescope.nvim' } }

    use { 'szw/vim-maximizer' }
    -- autocompletion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use { 'L3MON4D3/LuaSnip' }
    use 'rafamadriz/friendly-snippets'
    use 'onsails/lspkind-nvim'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use { 'saadparwaiz1/cmp_luasnip' }
    use 'lukas-reineke/cmp-rg'
    --
    -- GIT
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use 'tpope/vim-fugitive'
    use { 'junegunn/gv.vim', requires = { 'tpope/vim-fugitive' } }

    -- colorscheme
    use 'navarasu/onedark.nvim'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    use 'xiyaowong/nvim-transparent'

    -- IDE
    use 'liuchengxu/vista.vim'
    use "lukas-reineke/indent-blankline.nvim"
    -- Better language support

    use 'editorconfig/editorconfig-vim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Debug Adapter Protocol
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Markdown
    use 'npxbr/glow.nvim'
    -- UI Elements
    use 'nvim-lualine/lualine.nvim'
    --
    -- Colors
    use 'norcalli/nvim-colorizer.lua'
    use 'sunjon/shade.nvim'
    use 'folke/twilight.nvim'

    -- Project management
    use 'mhinz/vim-startify'

    -- Navigation
    use 'tmux-plugins/vim-tmux-focus-events'
    use 'christoomey/vim-tmux-navigator'
end)
--

local HOME = os.getenv('HOME')

vim.g.python3_host_prog = HOME .. '/.pyenv/versions/nvim/bin/python'
vim.g.mapleader = ' '
-- window-local options
vim.wo.number = true
vim.wo.relativenumber = true

-- global options
vim.o.compatible = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.splitright = true
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'
vim.o.termguicolors = true
vim.o.t_Co = 256
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.scrolloff = 4
vim.o.hidden = true
vim.o.autoread = true
vim.o.signcolumn = 'yes'
vim.opt.undofile = true
vim.o.completeopt = 'menuone,noselect'

vim.cmd [[set mouse= ]]
vim.cmd [[syntax on]]
-- vim.api.nvim_set_hl(0, "Normal", {ctermfg=None, ctermbg=None})
-- keymap(mode, mapping, operation, {opts})
local opts = { noremap = true }
vim.api.nvim_set_keymap('i', 'jk', '<esc>', opts)
vim.api.nvim_set_keymap('n', '<up>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<down>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<left>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<right>', '<Nop>', opts)

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

require('plugins.onedark')
require('plugins.nvim_tree')
require('plugins.telescope')
require('plugins.nvim_cmp')
require('plugins.luasnip')
require('plugins.dap')
require('plugins.lualine')
require('plugins.gitsigns')
require('plugins.lsp')
require('plugins.indentline')
require('colorizer').setup()
require('plugins.transparent')

-- Editor config
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }

-- maxmizer
vim.g.maximizer_set_mapping_with_bang = 1
vim.g.maximizer_set_default_mapping = 0
vim.api.nvim_set_keymap('n', '<leader>m', ':MaximizerToggle<CR>', opts)

vim.api.nvim_set_keymap('n', '<F9>', ':Vista!!<CR>', opts)
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_fzf_preview = { 'right:50%' }
vim.g['vista#renderer#enable_icon'] = 1

vim.api.nvim_set_keymap('n', '<leader>l', ':Twilight<CR>', opts)
-- TODO
-- autocmds, colorcolumn cursorline, stratify
