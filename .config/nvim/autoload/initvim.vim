" Functions for my init.vim
" SPDX-License-Identifier: GPL-3.0-or-later

function! initvim#GitSess()
    set autowriteall autoread
    set path+=**
    nnoremap ZZ :update \| close<CR>
    nnoremap g<Space> :G<Space>
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

let s:presentToggle = 0
function! initvim#present()
    if s:presentToggle == 1
        let s:presentToggle = 0
        source $MYVIMRC
        HardTimeOn
        echo 'Toggling presentation mode off'
    else
        let s:presentToggle = 1
        setglobal relativenumber& colorcolumn& list& cursorline&
        augroup PresentSettings
            autocmd!

            autocmd BufEnter * call initvim#updateLocalOptions()
        augroup END
        doautocmd BufEnter
        HardTimeOff
        let g:hardtime_default_on = 0
        echo 'Toggling presentation mode on (remember to increase font size)'
    endif
endfunction

function! initvim#updateLocalOptions()
    if &buftype == ''
        setlocal relativenumber< colorcolumn< list< cursorline<
    endif
endfunction

function! initvim#replacewithunnamedplus(type, ...)
    if a:type == 'line'
        let l:mode = 'V'
    elseif a:type == 'block'
        let l:mode = '\<C-V>'
    else
        let l:mode = 'v'
    endif
    silent execute 'normal `[' . l:mode . '`]"pc' . "\<C-R>+\<Esc>"
endfunction
