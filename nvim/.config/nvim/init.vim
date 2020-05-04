" ============================================================================

"-------------------- Active Plugins -------------------

call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code Commenter -------------------
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

"-------------------- Code/Project Navigation -------------------
Plug 'scrooloose/nerdtree'		" Project and file navigation
Plug 'majutsushi/tagbar'		" Class/module browser
" Plug 'liuchengxu/vista.vim'
"-------------------- File traversing -------------------
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"-------------------- Airline -------------------
Plug 'vim-airline/vim-airline'			
Plug 'vim-airline/vim-airline-themes'
" Plug 'itchyny/lightline.vim'

" Automatically close parenthesis, etc
" Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'		" Parentheses, brackets

" Indented lines
Plug 'Yggdroot/indentLine'

" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting and formating
" Plug 'dense-analysis/ale'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Colorscheme
Plug 'morhetz/gruvbox'

" Better language packs
" Plug 'sheerun/vim-polyglot'
" Plug 'vim-python/python-syntax'
Plug 'ap/vim-css-color'
call plug#end()


" ============================================================================

let g:python3_host_prog='/home/fm-pc-lt-146/envs/neovim3/bin/python'
" let g:python3_host_prog='/home/xitiz/anaconda3/envs/nvim/bin/python'

" Configurations
set number
set relativenumber

set expandtab				" expands tabs into space
set tabstop=4				" 4 whitespace for tabs visual presentation
set softtabstop=4
set shiftwidth=4			" shift lines by 4 space

" set splitbelow              " Preview windows in the bottom
set clipboard=unnamedplus

set t_Co=256
syntax on
colorscheme gruvbox
set background=dark

" leader
let mapleader=" "

set cursorline

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4

" clear search results
" nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Disable Arrow keys in Normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Disable esc and map to jk
imap jk <ESC>
" noremap <ESC> <nop>

" disable mouse
set mouse=

hi CursorLine term=underline cterm=underline ctermfg=None guifg=None ctermbg=None guibg=None

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=Gray guibg=Blue
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END


" ============================================================================
" Airline settings

let g:airline_powerline_fonts = 0
" let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
" ============================================================================
" YouCompleteMe
"
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
    \ 'g:ycm_python_interpreter_path',
    \ 'g:ycm_python_sys_path'
    \]

let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
" ============================================================================


" NERDTree settings
" autocmd vimenter * NERDTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']			" Ignore files in NERDTree
let NERDTreeWinSize=40
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd StdinReadPre * let s:std_in=1
map <C-n> :NERDTreeToggle<CR>
autocmd VimEnter * if !argc() | NERDTree | endif 			" Load NERDTree only if vim is run without arguments
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map ,t :NERDTreeFind<CR>

" ============================================================================

" Fzf ------------------------------
" nmap <leader><tab> <plug>(fzf-maps-n)
" Windowsize
" let g:fzf_preview_window = 'right:60%'
" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" buffers finder mapping
nmap ,b :Buffers<CR>

" ============================================================================

" Indent line
let g:indentLine_setColors = 0
" let g:indentLine_bgcolor_term = 202
let g:indentLine_char = '┊'

" ============================================================================
" Deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
" Use tabs for auto completeion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ============================================================================

" Jedi vim
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#auto_close_doc = 1

" Syntax
" let g:python_highlight_all = 1
