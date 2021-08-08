" Functions for my init.vim

function! aljoschua#EditOrSourceVimrc()
    if match(expand('%:p'), $MYVIMRC) != -1
        write
        source %
    else
        edit $MYVIMRC
    endif
endfunction

function! aljoschua#GitSess()
    set autowriteall autoread
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction
