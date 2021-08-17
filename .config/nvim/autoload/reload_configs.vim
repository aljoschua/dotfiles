function! reload_configs#i3()
    if g:reload_configs
        !i3-msg reload
    endif
endfunction

function! reload_configs#i3status()
    if g:reload_configs
        !i3-msg restart
    endif
endfunction

function! reload_configs#sxhkd()
    if g:reload_configs
        !systemctl --user reload sxhkd.service
    endif
endfunction

function! reload_configs#vim()
    if g:reload_configs
        source %
    endif
endfunction

function! reload_configs#systemd()
    if g:reload_configs
        !systemctl --user daemon-reload
    endif
endfunction
