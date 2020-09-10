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
Plug 'qpkorr/vim-bufkill'
" Restore FocusGained, FocusLost events in tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"LSP client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Text snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" General programming stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Git
Plug 'lambdalisue/gina.vim'
Plug 'rhysd/committia.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'fishbullet/deoplete-ruby'

" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'parsonsmatt/intero-neovim'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Rust
Plug 'rust-lang/rust.vim'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

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
set hidden
set tags=./tags

" Automatically refresh file contents
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

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
call deoplete#custom#option({
\ 'smart_case': v:true,
\ })
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Disable Preview panel
set completeopt-=preview

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
nnoremap <F4> :call LanguageClient_contextMenu()<CR>

" Goyo
let g:goyo_width = "60%"
let g:goyo_height = "85%"
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!
nnoremap <Leader>l :Goyo<CR>

"fzf
nmap ; :Buffers<CR>
nmap <Leader>o :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>a :Rg<CR>

"ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" NERDTree
let NERDTreeWinPos = "left"
map <F2> :NERDTreeToggle<CR>

" Gundo
let g:mundo_right = 1
map <F3> :MundoToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
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

"bufkill.vim
map <C-d> :BD<CR>

" Do not expand tabs into spaces when editing Makefile
autocmd FileType make setlocal noexpandtab

"ALE
let g:ale_fixers = {
      \    'ruby': ['rubocop'],
      \}
let g:ale_linters = {
      \    'ruby': ['rubocop'],
      \}
let g:ale_fix_on_save = 1

"haskell-vim
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

let g:intero_start_immediately = 0
let g:intero_use_neomake = 0

" rust.vim
let g:rustfmt_autosave = 1

" gina-vim
nnoremap <silent> <Leader>gs :Gina status<CR>
nnoremap <silent> <Leader>gc :Gina commit<CR>

let s:width_quarter = string(winwidth(0) / 4)
let s:width_half = string(winwidth(0) / 2)

" Open in vertical split
call gina#custom#command#option(
        \ '/\%(branch\|changes\|status\|grep\|log\|reflog\)',
        \ '--opener', 'vsplit'
        \)

" Fixed medium width types
call gina#custom#execute(
        \ '/\%(changes\|status\|ls\)',
        \ 'vertical resize ' . s:width_half . ' | setlocal winfixwidth'
        \)

" Fixed small width special types
call gina#custom#execute(
        \ '/\%(branch\)',
        \ 'vertical resize ' . s:width_quarter . ' | setlocal winfixwidth'
        \)
