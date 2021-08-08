" Functions for my init.vim


function! initvim#WriteAndReload()
    let l:file_reload_actions = {
                \ expand('~/.config/i3/config'):
                \   '!i3-msg reload',
                \ expand('~/.config/sxhkd/sxhkdrc'):
                \   '!systemctl --user reload sxhkd.service',
                \ expand('~/.config/nvim/init.vim'):
                \   'source %'}
    let l:file = expand('%:p')

    let l:dir_reload_actions  = {
                \ expand('~/.config/sxhkd/modes'):
                \   '!systemctl --user reload sxhkd.service',
                \ expand('~/.config/systemd/user'):
                \   '!systemctl --user daemon-reload'}
    let l:dir = expand('%:p:h')

    write " Maybe invoke sudo -A if necessary

    if has_key(l:file_reload_actions, l:file)
        execute l:file_reload_actions[l:file]
    endif

    if has_key(l:dir_reload_actions, l:dir)
        execute l:dir_reload_actions[l:dir]
    endif
endfunction

function! initvim#GitSess()
    set autowriteall autoread
    nnoremap ZZ :echoerr 'Use Ctrl-Z!'<CR>
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endfunction
