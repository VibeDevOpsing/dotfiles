" =============================================================================
" Modern Vim Configuration
" =============================================================================

" =============================================================================
" General Settings
" =============================================================================
set nocompatible              " Disable vi compatibility
filetype off                  " Required for plugin loading

" =============================================================================
" Plugin Management (Using vim-plug)
" =============================================================================
" Auto-install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Essential plugins
Plug 'tpope/vim-sensible'              " Sensible defaults
Plug 'tpope/vim-fugitive'              " Git integration
Plug 'tpope/vim-surround'              " Surround text objects
Plug 'tpope/vim-commentary'            " Easy commenting
Plug 'preservim/nerdtree'              " File explorer
Plug 'jiangmiao/auto-pairs'            " Auto close brackets
Plug 'airblade/vim-gitgutter'          " Git changes in gutter
Plug 'itchyny/lightline.vim'           " Status line
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                " Fuzzy finder
Plug 'sheerun/vim-polyglot'            " Language pack
Plug 'dense-analysis/ale'              " Async linting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP support

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nordtheme/vim'
Plug 'joshdick/onedark.vim'

call plug#end()

" Enable filetype detection, plugin and indent
filetype plugin indent on

" =============================================================================
" UI Configuration
" =============================================================================
syntax enable                 " Enable syntax highlighting
set termguicolors            " Enable true colors
set background=dark          " Dark background
colorscheme gruvbox          " Set colorscheme

" Line numbers
set number                   " Show line numbers
set relativenumber          " Relative line numbers
set numberwidth=4           " Width of number column

" UI elements
set showcmd                 " Show command in bottom bar
set showmode                " Show current mode
set ruler                   " Show cursor position
set laststatus=2           " Always show status line
set cmdheight=2            " Command line height
set signcolumn=yes         " Always show sign column
set cursorline             " Highlight current line
set colorcolumn=80,120     " Show column markers
set showmatch              " Highlight matching brackets
set matchtime=3            " Tenths of second to show match

" =============================================================================
" Editor Behavior
" =============================================================================
" Indentation
set expandtab              " Use spaces instead of tabs
set tabstop=4              " Tab width
set shiftwidth=4           " Indent width
set softtabstop=4          " Soft tab width
set autoindent             " Auto indent new lines
set smartindent            " Smart indenting
set shiftround             " Round indent to multiple of shiftwidth

" Text editing
set wrap                   " Wrap long lines
set linebreak              " Break lines at word boundaries
set textwidth=80           " Maximum text width
set formatoptions+=t       " Auto-wrap text
set backspace=indent,eol,start " Better backspace behavior

" Search
set incsearch              " Incremental search
set hlsearch               " Highlight search results
set ignorecase             " Case insensitive search
set smartcase              " Case sensitive if uppercase used
set magic                  " Enable regex magic

" Folding
set foldmethod=indent      " Fold based on indent
set foldnestmax=3          " Maximum fold depth
set foldlevelstart=99      " Start with all folds open
set foldenable             " Enable folding

" Splits
set splitbelow             " Horizontal splits below
set splitright             " Vertical splits to the right

" =============================================================================
" Performance & Files
" =============================================================================
set hidden                 " Allow hidden buffers
set autoread               " Auto reload changed files
set autowrite              " Auto save before commands
set updatetime=300         " Faster completion
set timeoutlen=500         " Timeout for key sequences
set ttimeoutlen=0          " No timeout for escape key
set lazyredraw             " Don't redraw during macros
set ttyfast                " Fast terminal connection

" Backup and swap
set nobackup               " No backup files
set nowritebackup          " No backup before overwrite
set noswapfile             " No swap files

" Persistent undo
if has('persistent_undo')
  set undofile             " Enable persistent undo
  set undodir=~/.vim/undo  " Undo directory
  set undolevels=1000      " Maximum undo levels
  set undoreload=10000     " Maximum lines to save
endif

" =============================================================================
" Completion
" =============================================================================
set wildmenu               " Command line completion
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.a
set wildignore+=*.pyc,*.pyo,__pycache__
set wildignore+=*.swp,*.swo,*.swn
set wildignore+=*.zip,*.tar,*.gz,*.bz2
set wildignore+=.git/*,.svn/*,.hg/*
set wildignore+=node_modules/*,vendor/*
set completeopt=menuone,noinsert,noselect
set pumheight=10           " Completion menu height

" =============================================================================
" Key Mappings
" =============================================================================
" Set leader key
let mapleader = " "
let maplocalleader = "\\"

" Better escape
inoremap jj <Esc>
inoremap jk <Esc>

" Save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" Better navigation
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window resizing
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bb :buffers<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tc :tabnew<CR>
nnoremap <leader>td :tabclose<CR>

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick editing
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

" Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" =============================================================================
" Plugin Configuration
" =============================================================================

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.pyc$', '__pycache__']
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>c :Commands<CR>

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" ALE
let g:ale_linters = {
      \ 'python': ['flake8', 'pylint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint', 'tsserver'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['black', 'isort'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~-'

" =============================================================================
" Auto Commands
" =============================================================================
augroup vimrc_autocmds
  autocmd!
  
  " Remove trailing whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
  
  " Return to last edit position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
    
  " Auto resize splits
  autocmd VimResized * wincmd =
  
  " Highlight yanked text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  
augroup END

" =============================================================================
" Custom Functions
" =============================================================================
" Toggle between number and relativenumber
function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>tn :call ToggleNumber()<CR>

" Strip trailing whitespace
function! StripTrailingWhitespace()
  let save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', save_cursor)
endfunc
nnoremap <leader>ss :call StripTrailingWhitespace()<CR>

" =============================================================================
" Local Configuration
" =============================================================================
" Source local configuration if it exists
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
