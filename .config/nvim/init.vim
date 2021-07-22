if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

" My Stuff

" File management
set nobackup undofile
set path-=/usr/include path+=**

" Tab Usage
set tabstop=4 shiftwidth=4 expandtab softtabstop=4

set number relativenumber

" Display blanks
set showbreak=↪\  list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲,conceal:␣
highlight SpecialKey ctermfg=red

set colorcolumn=81
set background=dark
set clipboard=unnamedplus

let mapleader = ' '

nnoremap <C-J> :cnext<CR>
nnoremap <C-K> :cprevious<CR>
nnoremap ZA :wqall<CR>
nnoremap <leader>v :if match(expand('%:p'), $MYVIMRC) != -1 \| write \| source % \| else \| edit $MYVIMRC \| endif<CR>
nnoremap <leader>m q:?^make<CR><CR>

iabbrev :vim-clean: vim:nu&:rnu&:list&:cc&:noru:ls=0:

function! GitSess()
    set autowrite
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction

command! Gitsess :call GitSess()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:plug_window = 'topleft new'

call plug#begin(stdpath('data') . '/vim-plug')

Plug  'vim-syntastic/syntastic'
Plug  'tpope/vim-fugitive'


call plug#end()
