let mapleader = " "

set clipboard=unnamed
set scrolloff=8
set number
set relativenumber
set laststatus=2
set hidden
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
set cursorline
set textwidth=120
set colorcolumn=120

filetype plugin indent on

" Switch between last two files
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>w :write<CR>

" Close current buffer
nnoremap <Leader>q :bd<CR>

" Open general vim settings
nnoremap <Leader>v :sp ~/.general<CR>

nnoremap <Leader>h :silent! nohls<cr>

" window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quickly switch between buffers
nnoremap <Leader>= :bprevious<CR>
nnoremap <Leader>- :bnext<CR>
nnoremap <Leader><Leader> :noh<CR>

" let's not do swapfiles, k?
set noswapfile

set noerrorbells " donkey!

set vb t_vb=

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Yank to end of line
nnoremap Y y$

" Toggle folds
nnoremap <Tab> za

autocmd FileType json,js,tf,rb setlocal ts=2 sw=2 sts=2

syntax on

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

set highlight+=c:LineNr
set highlight+=N:DiffText
set hlsearch
let @/ = ""

set foldmethod=indent
set nofoldenable

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/terminus'
call plug#end()

map <C-n> :NERDTreeToggle<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='minimalist'

let g:ctrlp_show_hidden = 1

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set updatetime=100
set timeoutlen=1000 ttimeoutlen=0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0