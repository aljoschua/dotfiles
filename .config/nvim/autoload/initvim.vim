" Functions for my init.vim

function! initvim#GitSess()
    set autowriteall autoread
    set path+=**
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    nnoremap <Leader>g :G<Space>
    set statusline=%<%f\ %h%m%r%{fugitive#Statusline()}%=%-14.(%l,%c%V%)\ %P
    if filereadable('Session.vim')
        source Session.vim
    endif
endfunction

function! initvim#badd(...)
    for files in a:000
        for file in split(expand(files), '\n')
            execute 'badd ' .  file
        endfor
    endfor
endfunction
