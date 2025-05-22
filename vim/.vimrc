" Modern Vim configuration with default plugins & modules and quiet color theme

" Disable vi compatibility
set nocompatible

" Use Vim packages (loads plugins under pack/*/start)
if has('packloadall')
  packloadall
endif

" Enable filetype detection, plugin and indent
filetype plugin indent on

" Syntax highlighting
syntax on

" Encoding settings
set encoding=utf-8

" Colorscheme settings — quiet palette
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme sorbet

" Mouse support in all modes
set mouse=a

" System clipboard integration
if has('clipboard')
  set clipboard=unnamedplus
endif

" Line numbering
set number
set relativenumber

" Highlight the current line
set cursorline

" Show matching brackets (disabled to avoid red highlight)
let g:matchparen_enabled = 0
" Override MatchParen highlight to clear any background
highlight MatchParen ctermbg=NONE guibg=NONE

" UI Tweaks
set showcmd                        " Show incomplete commands
set ruler                          " Show row/column of cursor
set cmdheight=1                    " Single line command bar
set laststatus=2                   " Always display status line

" Indentation settings
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
set cindent

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir//
endif

" Search settings
set incsearch                       " Incremental search
" set hlsearch                        " Disabled default search highlighting
set nohlsearch
set ignorecase                      " Case-insensitive search
set smartcase                       " Case-sensitive if uppercase used

" Command-line completion
set wildmenu
set wildignore+=*.o,*.obj,*.exe,*.dll,*.class,*.pyc,*.pyo,*.swp,*.zip,*.tar.gz,*.tar

" Folding
set foldmethod=syntax
set foldlevelstart=99

" Split window preferences
set splitbelow
set splitright

" Wrapping & text width
set wrap
set linebreak
set textwidth=80
" set colorcolumn=80               " Disabled vertical guide

" Performance optimizations
set lazyredraw
set ttyfast
set updatetime=300

" Default plugins & modules configuration
" NetRW (file explorer)
let g:netrw_banner=5
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25

" Tag support for ctags
set tags=./tags;,tags;

" Omni completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Status line customization
hi statusline guibg=DarkMagenta ctermfg=8 guifg=White ctermbg=15
set statusline=%<%f\ %h%m%r\ %=%{&ff}\ [TYPE=%Y]\ [POS=%04l,%04v]\ [LEN=%L]

" True color support
if has('termguicolors')
  set termguicolors
endif
