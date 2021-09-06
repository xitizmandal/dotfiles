" ============================================================================

"-------------------- Active Plugins -------------------

call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code Commenter -------------------
Plug 'tpope/vim-commentary'

"-------------------- Code/Project Navigation -------------------
Plug 'kyazdani42/nvim-tree.lua' " Project and file navigation
"-------------------- File traversing -------------------

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
"
" Automatically close parenthesis, etc
Plug 'tpope/vim-surround'		" Parentheses, brackets

" Indented lines
" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" Auto completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'

" Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Colorscheme
Plug 'navarasu/onedark.nvim'
" Plug 'tanvirtin/monokai.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" Better language support
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Debug Adapter Protocol
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
" Markdown
" Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'npxbr/glow.nvim'
"
"-------------------- UI Elements -------------------
" Plug 'vim-airline/vim-airline'			
" Plug 'vim-airline/vim-airline-themes'
Plug 'akinsho/bufferline.nvim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" Colors
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sunjon/shade.nvim'
Plug 'folke/twilight.nvim'

" Project management
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vista.vim'
" Navigation
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

call plug#end()


" ============================================================================

let g:python3_host_prog=expand('$HOME/.venvs/nvim/bin/python')
" let g:python3_host_prog='/home/xitiz/anaconda3/envs/nvim/bin/python'

" Configurations
set number
set nocompatible
set relativenumber

set expandtab				" expands tabs into space
set tabstop=4				" 4 whitespace for tabs visual presentation
set softtabstop=4
set shiftwidth=4			" shift lines by 4 space
" set splitbelow              " Preview windows in the bottom

set splitright
set clipboard+=unnamedplus

set termguicolors
set t_Co=256
syntax on

let g:onedark_style = "deep" 
let g:onedark_italic_comment = 1
colorscheme onedark
" set background=dark

" leader
let mapleader=" "

set cursorline

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmenu
" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4

" nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" noremap <ESC> <nop>

" disable mouse
set mouse=

"Change buffers without saving them
set hidden

"Do not conceal any level of codes, default is 2

set autoread

hi Normal ctermfg=None ctermbg=None
hi CursorLine term=underline cterm=underline ctermfg=None guifg=None ctermbg=None guibg=Black

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=Gray guibg=Gray
    autocmd FileType python match Excess /\%81v.*/
    autocmd FileType python set nowrap
    autocmd FileType python set colorcolumn=75,80
augroup END

" ============================================================================
" Custom mappings
nnoremap <leader>sv :source $MYVIMRC<CR>

" Disable Arrow keys in Normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Disable esc and map to jk
imap jk <ESC>

" Splits movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent>,bn :bn<CR>
nnoremap <silent>,bp :bp<CR>
" ============================================================================
" Indent line
" let g:indentLine_setColors = 0
" " let g:indentLine_bgcolor_term = 202
" let g:indentLine_char = '┊'
" let g:indentLine_conceallevel = 1

" ============================================================================
" Markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd filetype markdown normal zR 
let g:vim_markdown_conceal=0

" ============================================================================
" Completion nvim

" ============================================================================
" Colorizer
lua require'colorizer'.setup()

" ============================================================================
" Startify
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'p': '~/Documents/workspace/python' },
            \ { 'd': '~/dotfiles' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'c': '~/.config/i3/config' },
            \ ]
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1


" ============================================================================
" vista
nmap <F9> :Vista!!<CR>
let g:vista_default_executive = 'nvim_lsp'
let g:vista_fzf_preview = ['right:50%']
" let g:vista_echo_cursor_strategy = 'scroll'
let g:vista#renderer#enable_icon = 1

" ============================================================================
" ultisnips
let g:UltiSnipsSnippetsDir = '~/.local/share/nvim/plugged/vim-snippets/UltiSnips/'
let g:UltiSnipsSnippetDirectories =["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="numpy"

" ============================================================================
" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" ============================================================================
" Lsp Config
" ============================================================================
" Compe nvim
set completeopt=menuone,noselect
" set shortmess+=c


" ============================================================================

" Code navigation shortcuts
nmap ,lc :lclose<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
" set updatetime=300
" " Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" " Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
" nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" Remove jitterness when errors are poping around
set signcolumn=yes
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" ============================================================================
" vim maximizer
let g:maximizer_set_mapping_with_bang = 1
let g:maximizer_set_default_mapping=0
" let g:maximizer_default_mapping_key = '<leader>m'
noremap <leader>m :MaximizerToggle<CR>

source $HOME/.config/nvim/plugins/nvimtree.vim

lua require('plugins.lsp')
lua require('plugins.telescope')
lua require('plugins.nvim_cmp')
lua require('plugins.buffline')
" lua require('plugins.lsp_signature')
lua require('plugins.dap')
" lua require('plugins.galaxyline')
lua require('plugins.status_line')
lua require('gitsigns').setup()
lua require('plugins.indentline')
" set conceallevel=0

" lua <<EOF
" require'shade'.setup({
"     overlay_opacity = 60,
"     opacity_step = 0,
"     keys =  {
"         toggle = '<Leader>o',
"     }
" })
" EOF
nnoremap <leader>l :Twilight<CR>
