" Functions for my init.vim


function! aljoschua#ReloadOrEditVimrc()
    let l:reload_actions = {expand('~/.config/i3/config'): '!i3-msg reload',
                \ expand('~/.config/sxhkd/sxhkdrc'): '!systemctl --user reload sxhkd.service',
                \ expand('~/.config/nvim/init.vim'): 'source %'}
    let l:file = expand('%:p')

    if has_key(l:reload_actions, l:file)
        write
        execute l:reload_actions[l:file]
        return
    endif

    if expand('%:p:h') == expand('~/.config/sxhkd/modes')
        write
        !systemctl --user reload sxhkd.service
        return
    endif

    " No reloadable file was detected
    edit $MYVIMRC
endfunction

function! aljoschua#GitSess()
    set autowriteall autoread
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction
