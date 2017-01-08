function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/plugins')

Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'arakashic/nvim-colors-solarized'
Plug 'junegunn/seoul256.vim'

" General text editing
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-sleuth'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Text snippets
Plug 'SirVer/ultisnips'

" General programming stuff
Plug 'kien/ctrlp.vim'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': [] }
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Slim
Plug 'slim-template/vim-slim', { 'for': 'slim' }

" CoffeeScript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" HAML
Plug 'tpope/vim-haml', { 'for': 'haml' }

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
let g:alchemist_tag_disable = 1
Plug 'powerman/vim-plugin-AnsiEsc'

" Phoenix
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'

" Testing shit
Plug 'neomake/neomake'

call plug#end()

""""" Vim settings
set termguicolors
colorscheme solarized8_dark

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
set noautowrite
set nobackup
set autoread
set confirm
set laststatus=2
set mouse=
set expandtab

" File ignoring
set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
        \*.jpeg,*.png,*.gif,*.pdf,*.git,
        \*.swp,*.swo
set wildmenu
set wildmode=longest,list

" Spellchecking!
set complete+=kspell

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

" Split navigation via Tab? Yes please.
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

""""" Plugin specific settings

" vim-fugitive
nmap <Leader>g :Gstatus<CR>gg<c-n>
noremap <Leader>d :Gdiff<CR>

" Goyo
let g:goyo_width = "60%"
let g:goyo_height = "85%"
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!
nnoremap <Leader>l :Goyo<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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

" rainbow_parentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
call plug#load('rainbow_parentheses.vim')
call rainbow_parentheses#activate()

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'
let g:bufferline_echo = 0

" Tagbar
inoremap <F4> <esc>:TagbarToggle<cr>
nnoremap <F4> :TagbarToggle<cr>
let g:tagbar_sort = 0

" Create parent directories if they don't exist
" http://vi.stackexchange.com/questions/678/how-do-i-save-a-file-in-a-directory-that-does-not-yet-exist
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

" Deoplete
let g:deoplete#enable_at_startup = 1

" vim-pandoc
let g:pandoc#after#modules#enabled = ["ultisnips"]

autocmd! BufWritePost * Neomake
autocmd! BufReadPost * Neomake
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

"""" Shamelessly stolen from https://github.com/junegunn/dotfiles/blob/master/vimrc
"----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> "#!!" "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
