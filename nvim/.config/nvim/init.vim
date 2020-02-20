" ============================================================================

"-------------------- Active Plugins -------------------

call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code Commenter -------------------
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

"-------------------- Code/Project Navigation -------------------
Plug 'scrooloose/nerdtree'		" Project and file navigation
" Plug 'majutsushi/tagbar'		" Class/module browser

"-------------------- File traversing -------------------
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"-------------------- Airline -------------------
Plug 'vim-airline/vim-airline'			
Plug 'vim-airline/vim-airline-themes'

" Automatically close parenthesis, etc
" Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'		" Parentheses, brackets

" Indented lines
Plug 'Yggdroot/indentLine'

" Auto completion
Plug 'ycm-core/YouCompleteMe'

" Colorscheme
Plug 'dikiaap/minimalist'
call plug#end()

" ============================================================================

let g:python3_host_prog='/home/xitiz/anaconda3/envs/nvim/bin/python'

" Configurations
set number
set relativenumber

set expandtab				" expands tabs into space
set tabstop=4				" 4 whitespace for tabs visual presentation
set softtabstop=4
set shiftwidth=4			" shift lines by 4 space

set t_Co=256
syntax on
colorschem minimalist
set background=dark

set cursorline
" hi CursorLine term=bold cterm=bold guibg=Grey40
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
" inoremap <ESC> <nop>

" disable mouse
set mouse=

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" ============================================================================

" Airline settings
" let g:airline_powerline_fonts = 0
" let g:airline_theme = 'bubblegum'
" let g:airline#extensions#whitespace#enabled = 0

let g:airline_theme = 'minimalist'
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
" commands finder mapping
" nmap ,c :Commands<CR>

" ============================================================================

" Indent line
let g:indentLine_setColors = 0
