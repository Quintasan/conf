call plug#begin('~/.config/nvim/plugins')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frankier/neovim-colors-solarized-truecolor-only'

" General text editing
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-sleuth'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Text snippets
Plug 'SirVer/ultisnips'

" General programming stuff
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Slim
Plug 'slim-template/vim-slim'

" HAML
Plug 'tpope/vim-haml'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'fishbullet/deoplete-ruby'

" Rust
Plug 'rust-lang/rust.vim'

" Haskell
Plug 'vim-scripts/haskell.vim'
Plug 'itchyny/vim-haskell-indent'
Plug 'eagletmt/neco-ghc'
Plug 'eagletmt/ghcmod-vim'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Elixir
Plug 'awetzel/elixir.nvim'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Testing shit
Plug 'neomake/neomake'
Plug 'Shougo/neopairs.vim'

call plug#end()

""""" Vim settings
set termguicolors
set background=dark
colorscheme solarized

" General settings
set showcmd
set showmatch
set showmode
set ruler
set number
set relativenumber
set cursorline
set undofile
set undodir=~/.config/nvim/undo
set undolevels=500
set undoreload=10000
set nowrap
set noshowmode
set autowrite
set nobackup
set autoread
set noconfirm
set laststatus=2
set mouse=
set expandtab

" File ignoring
set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
        \*.jpeg,*.png,*.gif,*.pdf,*.git,
        \*.swp,*.swo
set wildmenu
set wildmode=list:longest,full

" More natural splits
set splitbelow
set splitright

" Show whitespaces
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list

" Use X11 clipboard since I'm goddamn lazy
set clipboard+=unnamedplus

" Return to last edit position when opening files
augroup LastPosition
  autocmd! BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \       exe "normal! g`\"" |
        \ endif
augroup END

""""" Keyboard maps
let mapleader = "\<Space>"

" Buffers are the new tabs

nnoremap gn :bnext<CR>
nnoremap gN :bprev<CR>

" Treat wraped lines as normal lines
nnoremap j gj
nnoremap k gk

" Ex more pls go
map Q <nop>

nmap <silent> <leader>s :set spell!<CR>

""""" Plugin specific settings

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Neomake
autocmd! BufRead,BufWritePost * Neomake
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" vim-fugitive
nmap <Leader>g :Gstatus<CR>gg<c-n>
noremap <Leader>d :Gdiff<CR>

" Goyo
let g:goyo_width = "60%"
let g:goyo_height = "85%"
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!
nnoremap <Leader>l :Goyo<CR>

" CtrlP
let g:ctrlp_by_filename = 1
let g:ctrlp_cache_dir = $HOME.'/.nvim/ctrlp_cache'
let g:ctrlp_map = "<Leader>o"
nnoremap <Leader>o :CtrlPMixed<CR>
if executable("/usr/bin/ag")
  set grepprg="/usr/bin/ag --nogroup --nocolor"
  let g:ctrlp_use_caching = 0
  let g:ctrlp_clear_cache_on_exit = 1
  let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

" NERDTree
let NERDTreeWinPos = "left"
map <F2> :NERDTreeToggle<CR>

" Gundo
let g:mundo_right = 1
map <F3> :MundoToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0

" Create parent directories if they don't exist
" http://vi.stackexchange.com/questions/678/how-do-i-save-a-file-in-a-directory-that-does-not-yet-exist
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

" vim-pandoc
let g:pandoc#after#modules#enabled = ["ultisnips", "supertab"]

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1               " to enable highlighting of backpack keywords
