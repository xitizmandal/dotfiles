call plug#begin('~/.local/share/nvim/plugged')

" File explorer
Plug 'scrooloose/nerdtree'

" Themes
" Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'

" Auto complete
Plug 'Valloric/YouCompleteMe'
" Syntau Checking/Higlighting
Plug 'sheerun/vim-polyglot'
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Multiline cursor
" Plug 'terryma/vim-multiple-cursors'

" FZF
Plug '~/.fzf', {'do':'./install --all' }
" Git gutter
"Plug 'airblade/vim-gutter'

" brackets
Plug 'tpope/vim-surround'
" Indented lines
Plug 'Yggdroot/indentLine'
call plug#end()

let g:python3_host_prog='/home/lt144/Documents/anaconda3/envs/neovim/bin/python'
" Color Scheme
if (has('termguicolors'))
	set termguicolors
endif

syntax enable
set background=dark
colorscheme one
"colorscheme solarized

" airline theme
let g:airline_theme='one'
" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclartaion<CR>

" Nerd Tree
autocmd vimenter * NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd StdinReadPre * let s:std_in=1
map <C-n> :NERDTreeToggle<CR>
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Configurations
set number
set relativenumber
filetype plugin indent on

" Indent line
let g:indentLine_setColors = 0

" cursorlie
set cursorline

" disable mouse
set mouse=
