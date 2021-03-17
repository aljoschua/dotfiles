if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

    augroup END

endif " has("autocmd")

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

nnoremap <C-J> :cn<CR>
nnoremap <C-K> :cp<CR>

function! GitSess()
    set autowrite
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction

command! Gitsess :call GitSess()
command! Rc :edit ~/.config/nvim/init.vim
