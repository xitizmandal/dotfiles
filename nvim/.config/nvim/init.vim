call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code/Project Navigation -------------------
Plug 'scrooloose/nerdtree'		" Project and file navigation
Plug 'majutsushi/tagbar'		" Class/module browser
Plug 'kien/ctrlp.vim'			" Fast transitioins on project files


"-------------------- Others -------------------
Plug 'vim-airline/vim-airline'			
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/TaskList.vim'		" Task List
Plug 'tpope/vim-surround'		" Parentheses, brackets
" Plug 'flazz/vim-colorschemes'		" Colorschemes
Plug 'rakr/vim-one'
" Themes
" Plug 'joshdick/onedark.vim'

"-------------------- Snippets support ------------
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'

" Languange support
Plug 'tpope/vim-commentary'
Plug 'mitsuhiko/vim-sparkup'
Plug 'Valloric/YouCompleteMe'

" Python
Plug 'python-mode/python-mode', {'branch':'develop'}
Plug 'scrooloose/syntastic'

" FZF
Plug '~/.fzf', {'do':'./install --all' }
" Git gutter
"Plug 'airblade/vim-gutter'

" brackets
" Indented lines
Plug 'Yggdroot/indentLine'
call plug#end()

let g:python3_host_prog='/home/lt144/Documents/anaconda3/envs/neovim/bin/python'
" Color Scheme
if (has('termguicolors'))
	set termguicolors
endif


filetype on
filetype plugin on
filetype plugin indent on

" General Settings
syntax enable				" syntax highlight

set t_Co=256				" set 256 colors
set background=dark
colorscheme one

set number
set ruler

set tabstop=4				" 4 whitespace for tabs visual presentation
set shiftwidth=4			" shift lines by 4 space
set smarttab				" set tabs for shifttabs logic
set expandtab				" expands tabs into space
set autoindent				" indent when moving to next line while writing code

set cursorline				" show line under cursor's line
set showmatch				" shows matching part of bracket pairs (), [], {}

set enc=utf-8

set nobackup
set nowritebackup
set noswapfile

set backspace=indent,eol,start		" backspace removes all (indents, EOLS, start)

set scrolloff=10			" let 10 lines before/afer cursor during scroll

set clipboard=unnamed			" use system clipboard

" Airline settings
let g:airline_theme='one'		
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

" TagBar settings
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose

" NERDTree settings
" autocmd vimenter * NERDTree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']			" Ignore files in NERDTree
let NERDTreeWinSize=40
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd StdinReadPre * let s:std_in=1
map <C-n> :NERDTreeToggle<CR>
autocmd VimEnter * if !argc() | NERDTree | endif 			" Load NERDTree only if vim is run without arguments
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" SnipMate settings
" let g:snippets_dir='~/.vim/vim-snippets/snippets'


" Configurations
set number
set relativenumber

" Indent line
let g:indentLine_setColors = 0

" cursorlie

" disable mouse
set mouse=

" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclartaion<CR>

filetype plugin indent on

"=====================================================
"python settings
"=====================================================

" python executables for different plugins
let g:pymode_python='python'
let g:syntastic_python_python_exec='python'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']

" YouCompleteMe
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>

