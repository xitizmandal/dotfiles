" ============================================================================

"-------------------- Active Plugins -------------------

call plug#begin('~/.local/share/nvim/plugged')

"-------------------- Code Commenter -------------------
Plug 'tpope/vim-commentary'

"-------------------- Code/Project Navigation -------------------
Plug 'kyazdani42/nvim-tree.lua' " Project and file navigation
Plug 'liuchengxu/vista.vim'     " Class/module browser
"-------------------- File traversing -------------------

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
"-------------------- Airline -------------------
Plug 'vim-airline/vim-airline'			
Plug 'vim-airline/vim-airline-themes'
Plug 'akinsho/nvim-bufferline.lua'
" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Automatically close parenthesis, etc
Plug 'tpope/vim-surround'		" Parentheses, brackets

" Indented lines
Plug 'Yggdroot/indentLine'

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
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Colorscheme
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" Better language support
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Markdown
" Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'npxbr/glow.nvim'
"

" Colors
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sunjon/shade.nvim'
Plug 'folke/twilight.nvim'

" Project management
Plug 'mhinz/vim-startify'

" Navigation
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Debug Adapter Protocol
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
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
colorscheme onedark
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
" " Airline settings

" let g:airline#extensions#whitespace#enabled = 0

" let g:airline_theme = 'onedark'
" let g:airline_powerline_fonts = 0
" let g:airline#extensions#tabline#enabled = 1

" ============================================================================

" " Fzf ------------------------------
" " nmap <leader><tab> <plug>(fzf-maps-n)
" " Windowsize
" let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', } }
" " let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
" let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!**/{.git,__pycache__,node_modules,vendor}/*"'
" let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --theme=\"OneHalfDark\" --style=header,grid --line-range :300 {}'"
" command! -bang -nargs=? -complete=dir Files
"      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!**/{.git,__pycache__,node_modules,vendor}/*" '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
" " File mappings
" nmap ,ff :Files<CR>  
" nmap ,fb :Buffers<CR>
" nmap ,fg :Rg<CR>
" nmap ,fC :Commits<CR>
" nmap ,fc :BCommits<CR>
" nmap ,fd :GFiles?<CR>
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }
" ============================================================================
" Indent line
let g:indentLine_setColors = 0
" let g:indentLine_bgcolor_term = 202
let g:indentLine_char = '┊'
let g:indentLine_conceallevel = 1

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
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" let g:vista_icon_indent = ["▸ ", ""]
":vista_echo_cursor_strategy = 'both'

" function! NearestMethodOrFunction() abort
"     return get(b:, 'vista_nearest_method_or_function', '')
" endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set statusline+=%{NearestMethodOrFunction()}
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

" ============================================================================
" Black
" nnoremap <F6> :Black<CR>

" ============================================================================
" Editorconfig
" let g:EditorConfig_core_mode = 'external_command'

" ============================================================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF

" ============================================================================
" vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
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

set conceallevel=0

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
