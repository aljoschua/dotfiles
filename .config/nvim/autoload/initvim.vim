" Functions for my init.vim

function! initvim#GitSess()
    set autowriteall autoread
    set path+=**
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction
