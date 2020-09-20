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
Plug 'zchee/deoplete-clang'

" Linting and formating
Plug 'dense-analysis/ale'

" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Colorscheme
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'

" Better language packs
Plug 'sheerun/vim-polyglot'
" Plug 'vim-python/python-syntax'
"Plug 'ap/vim-css-color'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'metakirby5/codi.vim'

" Markdown
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Colors
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()


" ============================================================================

let g:python3_host_prog='/home/fm-pc-lt-146/envs/neovim3/bin/python'
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
set clipboard+=unnamedplus

set t_Co=256
syntax on
colorscheme gruvbox
" set background=dark

" leader
let mapleader=" "

set cursorline

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4

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

"Change buffers without saving them
set hidden

"Do not conceal any level of codes, default is 2
set conceallevel=0

hi Normal ctermfg=None ctermbg=None
" hi CursorLine term=underline cterm=underline ctermfg=None guifg=None ctermbg=None guibg=None

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=White guibg=White
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=75,80
augroup END

nnoremap <leader>sv :source $MYVIMRC<CR>
" ============================================================================
" Airline settings

let g:airline#extensions#whitespace#enabled = 0

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
" ============================================================================


" NERDTree settings
" autocmd vimenter * NERDTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']			" Ignore files in NERDTree
let NERDTreeWinSize=40
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd StdinReadPre * let s:std_in=1
map <C-n> :NERDTreeToggle<CR>
" autocmd VimEnter * if !argc() | NERDTree | endif 			" Load NERDTree only if vim is run without arguments
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map ,t :NERDTreeFind<CR>

" ============================================================================

" Fzf ------------------------------
" nmap <leader><tab> <plug>(fzf-maps-n)
" Windowsize
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', } }
" let g:fzf_layout = {'window':{'width': 0.8, 'height': 0.6}}
" let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git, __pycache__,node_modules,vendor}/*"'
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

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

" Commits history
nmap ,C :Commits<CR>

" Commits history for current buffer
nmap ,c :BCommits<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
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
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ============================================================================

" Jedi vim
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
set completeopt-=preview

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#auto_close_doc = 1

" Syntax
" let g:python_highlight_all = 1

" ============================================================================
" Clang
let g:deoplete#sources#clang#libclang_path = "/usr/lib/llvm-6.0/lib/libclang-6.0.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"

" ============================================================================
" Markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd filetype markdown normal zR 
let g:vim_markdown_conceal=0
" ============================================================================
" ALE
let g:ale_linters = {
    \ 'python': ['flake8', 'pylint', 'black'],
    \ }
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" let g:ale_set_loclist = 0
" let g:ale_open_list = 1
" let g:ale_set_quickfix = 1
nmap ,lo :lopen<CR>
nmap ,lc :lclose<CR>
nmap ,ln :lnext<CR>
nmap ,lp :lprevious<CR>
