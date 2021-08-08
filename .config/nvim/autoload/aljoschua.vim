" Functions for my init.vim

function! aljoschua#EditOrSourceVimrc()
    if match(expand('%:p'), $MYVIMRC) != -1
        write
        source %
    else
        edit $MYVIMRC
    endif
endfunction

function! aljoschua#Reload() " Could also use autocmds....
    let l:file = expand('%:p')
    if l:file == expand('~/.config/i3/config')
        !i3-msg reload
    elseif l:file == expand('~/.config/sxhkd/sxhkdrc') || expand('%:p:h') == expand('~/.config/sxhkd/modes')
        !systemctl --user reload sxhkd.service
    endif
endfunction

function! aljoschua#GitSess()
    set autowriteall autoread
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction
