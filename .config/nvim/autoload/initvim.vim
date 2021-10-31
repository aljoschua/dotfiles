" Functions for my init.vim

function! initvim#GitSess()
    set autowriteall autoread
    set path+=**
    nnoremap ZZ :update \| close<CR>
    nnoremap <Leader>g :G<Space>
    set statusline=%<%f\ %h%m%r%{fugitive#Statusline()}%=%-14.(%l,%c%V%)\ %P
endfunction

function! initvim#badd(...)
    for files in a:000
        for file in split(expand(files), '\n')
            if filereadable(file)
                execute 'badd ' .  file
            endif
        endfor
    endfor
endfunction

function! initvim#present()
    set relativenumber& colorcolumn& list&
    HardTimeOff
endfunction
