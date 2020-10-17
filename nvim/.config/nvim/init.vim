" ============================================================================

"-------------------- Active Plugins -------------------

call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code Commenter -------------------
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

"-------------------- Code/Project Navigation -------------------
Plug 'scrooloose/nerdtree'		" Project and file navigation
Plug 'majutsushi/tagbar'		" Class/module browser
Plug 'liuchengxu/vista.vim'     " Class/module browser with coc vim
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'
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

" Better language support
Plug 'sheerun/vim-polyglot'
Plug 'metakirby5/codi.vim'
Plug 'editorconfig/editorconfig-vim'

" Markdown
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Colors
Plug 'norcalli/nvim-colorizer.lua'

" Project management
Plug 'mhinz/vim-startify'

" Navigation
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
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
set splitright
set clipboard+=unnamedplus

set termguicolors
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

" noremap <ESC> <nop>

" disable mouse
set mouse=

"Change buffers without saving them
set hidden

"Do not conceal any level of codes, default is 2
set conceallevel=0

set autoread

hi Normal ctermfg=None ctermbg=None
" hi CursorLine term=underline cterm=underline ctermfg=None guifg=None ctermbg=None guibg=None

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
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,__pycache__,node_modules,vendor}/*"'
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --theme=gruvbox --style=header,grid --line-range :300 {}'"
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

" ============================================================================
" Codi
highlight CodiVirtualText guifg='#00ff80'
let g:codi#virtual_text_prefix = "repl❯ "
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
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
" let g:vista_echo_cursor_strategy = 'scroll'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" let g:vista_icon_indent = ["▸ ", ""]
":vista_echo_cursor_strategy = 'both'

" ============================================================================
" ultisnips
let g:UltiSnipsSnippetsDir = '~/.local/share/nvim/plugged/vim-snippets/UltiSnips/'
let g:UltiSnipsSnippetDirectories =["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="numpy"
" " coc snippets
" "" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" ============================================================================
" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
