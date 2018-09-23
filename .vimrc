let mapleader = " "

syntax on
filetype plugin indent on

set clipboard=unnamed
set scrolloff=8
set number
set relativenumber
set laststatus=2
set ttyfast
set lazyredraw

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
set textwidth=100
set colorcolumn=100

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

highlight ColorColumn ctermbg=235 guibg=#1C262B

set highlight+=c:LineNr
set highlight+=@:ColorColumn

highlight LineNr ctermfg=238
set hlsearch
let @/ = ""

hi! MatchParen cterm=none ctermbg=black ctermfg=white
hi! Error cterm=reverse ctermbg=white ctermfg=red

autocmd BufRead,BufNewFile Berksfile set filetype=ruby

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


" Toggle folds
nnoremap <Tab> za

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
Plug 'fatih/vim-go'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-git'
Plug 'pangloss/vim-javascript'
Plug 'chr4/nginx.vim'
Plug 'vim-python/python-syntax'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'leafgarland/typescript-vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'stephpy/vim-yaml'

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
Plug 'junegunn/limelight.vim'
Plug 'mattn/calendar-vim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration goes under here!
""""""""""""""""""""""""""""""""""""""""

" Lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

nmap <Leader>n <Plug>VimwikiIndex
nmap <Leader>i <Plug>VimwikiDiaryIndex
nmap <Leader>d <Plug>VimwikiMakeDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>c :Calendar<CR>

let g:calendar_options = 'nornu'

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
nmap ; :Buffers<CR>
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

