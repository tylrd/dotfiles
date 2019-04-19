let mapleader = " "

syntax on
filetype plugin indent on

filetype plugin on
source $VIMRUNTIME/macros/matchit.vim

set clipboard=unnamed
set scrolloff=8
set number
set relativenumber
set laststatus=2
" set ttyfast
" set lazyredraw

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Remove 'set hidden'
set nohidden

" https://github.com/tpope/vim-vinegar/issues/13
augroup netrw_buf_hidden_fix
    autocmd!

    " Set all non-netrw buffers to bufhidden=hide
    autocmd BufWinEnter *
                \  if &ft != 'netrw'
                \|     set bufhidden=hide
                \| endif

augroup end

" https://github.com/thoughtbot/dotfiles/blob/master/vimrc
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

augroup END

set confirm
set nocompatible
set ts=4
set sw=4
set sts=4
set expandtab
set ruler
set list
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set gdefault
set mouse=a
set background=dark
set textwidth=150

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set incsearch
set wildmenu
set history=1000

if !has('gui_running')
  set t_Co=256
endif

" persistent undo
set undofile
set undodir=~/.vim/undodir

" let's not do swapfiles, k?
set noswapfile

" donkey!
set noerrorbells
set vb t_vb=

set updatetime=100
set timeoutlen=1000 ttimeoutlen=0

set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules,.terraform,.gradle

" highlight ColorColumn ctermbg=235 guibg=#1C262B

" set highlight+=c:LineNr
" set highlight+=@:ColorColumn

set hlsearch
let @/ = ""

hi! MatchParen cterm=none ctermbg=black ctermfg=white
hi! Error cterm=reverse ctermbg=white ctermfg=red

autocmd BufRead,BufNewFile Berksfile set filetype=ruby

command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e
command! W w
command! Wq wq

" Switch between last two files
nnoremap <Leader>b <C-^>

nnoremap <Leader>w :write<CR>

nnoremap <Leader>f :Rg<CR>

" Easier editing of .vimrc
nnoremap <Leader>v :sp ~/.vimrc<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>

nnoremap <Leader>h :silent! nohls<cr>

" Quickly switch between buffers
nnoremap <Leader><Left> :bprevious<CR>
nnoremap <Leader><Right> :bnext<CR>

" Turn off highlight searches
nnoremap <Leader><Leader> :noh<CR>

" Remap j and k to act as expected when used on long, wrapped, lines
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Yank to end of line
nnoremap Y y$

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap \q :nohlsearch<CR>
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \x :cclose<CR>
nmap \g :Gstatus<CR>

autocmd filetype crontab setlocal nobackup nowritebackup
autocmd BufRead,BufNewFile Berksfile* set filetype=ruby
autocmd BufNewFile,BufRead *.yml set filetype=yaml

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists

set foldmethod=indent
set nofoldenable

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Language Packs
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" tpop
" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

" align blocks of text
Plug 'junegunn/vim-easy-align'

" https://github.com/jiangmiao/auto-pairs/issues/74
Plug 'tylrd/auto-pairs'

Plug 'airblade/vim-gitgutter'

" better vim integration with terminal
Plug 'wincent/terminus'

" fuzzy find
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" status bar
Plug 'itchyny/lightline.vim'

" wiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" Plug 'junegunn/limelight.vim'
Plug 'mattn/calendar-vim'
Plug 'Konfekt/FastFold'

Plug 'cocopon/iceberg.vim'
Plug 'nanotech/jellybeans.vim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration goes under here!
""""""""""""""""""""""""""""""""""""""""

let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}

if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif

colorscheme jellybeans
" colorscheme iceberg

let g:ruby_fold = 1
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx"

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" Lightline
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

nmap <Leader>n <Plug>VimwikiIndex
nmap <Leader>i <Plug>VimwikiDiaryIndex
nmap <Leader>d <Plug>VimwikiMakeDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>c :Calendar<CR>

let g:calendar_options = 'nornu'
let g:go_version_warning = 0

let g:AutoPairsMultilineClose=0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

" FZF bindings
nmap <silent> <C-p> :Buffers<CR>
nmap <silent> <C-t> :ProjectFiles<CR>
nmap <silent> <C-f> :Ag<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

" http://vim.wikia.com/wiki/Maximize_window_and_return_to_previous_split_structure
function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" Fugitive
set diffopt+=vertical

nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" reset certain things to black
hi! Normal ctermbg=000 ctermfg=252 guibg=#161821 guifg=#c6c8d1
hi! LineNr ctermbg=000 ctermfg=239 guibg=#1e2132 guifg=#444b71
" hi! CursorLineNr ctermbg=000 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6
" hi! EndOfBuffer ctermbg=000 ctermfg=236 guibg=#161821 guifg=#242940
" hi! GitGutterAdd ctermbg=000 ctermfg=150 guibg=#1e2132 guifg=#b4be82
" hi! GitGutterChange ctermbg=000 ctermfg=109 guibg=#1e2132 guifg=#89b8c2
" hi! GitGutterChangeDelete ctermbg=000 ctermfg=109 guibg=#1e2132 guifg=#89b8c2
" hi! GitGutterDelete ctermbg=000 ctermfg=203 guibg=#1e2132 guifg=#e27878

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

vnoremap p "_dP
nmap <Leader>p :let @*=expand("%")<CR>
