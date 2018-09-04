let mapleader = " "

syntax on
filetype plugin indent on

set clipboard=unnamed
set scrolloff=8
set number
set relativenumber
set laststatus=2
set lazyredraw

" When on, Vim will change the current working directory whenever you
" open a file, switch buffers, delete a buffer or open/close a window.
" It will change to the directory containing the file which was opened
" or selected.
set autochdir

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
" set cursorline
set textwidth=100
set colorcolumn=100

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set incsearch
set wildmenu
set history=1000

set cursorline

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

" set updatetime=100
" set timeoutlen=1000 ttimeoutlen=0

set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules,.terraform,.gradle

highlight CursorLine cterm=bold ctermbg=235 guibg=Grey40
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight StatusLine   cterm=NONE ctermbg=235 ctermfg=white
highlight StatusLineNC cterm=NONE ctermbg=235 ctermfg=white

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

set highlight+=c:LineNr
set highlight+=@:ColorColumn

highlight LineNr ctermfg=235
set hlsearch
let @/ = ""

hi! MatchParen cterm=none ctermbg=black ctermfg=white
hi! Error cterm=reverse ctermbg=white ctermfg=red

" Switch between last two files
nnoremap <Leader>b <C-^>

nnoremap <Leader>w :write<CR>

" Close current buffer
nnoremap <Leader>qq :bd<CR>

" Easier editing of .vimrc
nnoremap <Leader>v :sp ~/.vimrc<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>

nnoremap <Leader>h :silent! nohls<cr>

" Quickly switch between buffers
nnoremap <Leader><Left> :bprevious<CR>
nnoremap <Leader><Right> :bnext<CR>

" Turn off highlight searches
nnoremap <Leader><Leader> :noh<CR>

" Copy rest of line to line above
nnoremap <Leader>p DO<c-r>"<esc>

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
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/groovyindent-unix'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

Plug 'junegunn/vim-easy-align'

" https://github.com/jiangmiao/auto-pairs/issues/74
Plug 'tylrd/auto-pairs'

Plug 'airblade/vim-gitgutter'
Plug 'wincent/terminus'

" prose
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

" wiki
Plug 'reedes/vim-colors-pencil'

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
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

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set nocursorline
  set tw=0
  set scrolloff=999
  colorscheme pencil
  Limelight
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  highlight CursorLine cterm=bold ctermbg=235 guibg=Grey40
  highlight ColorColumn ctermbg=235 guibg=#2c2d27
  highlight LineNr ctermfg=235
  set highlight+=c:LineNr
  set highlight+=@:ColorColumn
  set hlsearch
  let @/ = ""
  Limelight!
  if b:quitting
    if b:quitting_bang
      wqa!
    else
      wqa
    endif
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END

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

" FZF bindings
nmap ; :Buffers<CR>
nmap <silent> <C-t> :Files<CR>
nmap <Leader>a :Ag<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

