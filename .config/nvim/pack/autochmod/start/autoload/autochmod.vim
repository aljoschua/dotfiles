let s:got_working_passwd = 0

function! autochmod#BufWritePre()
    let l:file = expand('%')

    " Ask for password
    if s:got_working_passwd != 1
        let s:passwd = inputsecret('[AutoChmod] enter password: ')
    endif
    if empty(s:passwd)
        return
    endif
    echo "\n"

    " Change permissions
    let l:error_msg = system('sudo -S chmod o+w -- ' . l:file, s:passwd)
    if v:shell_error
        echohl Error
        echo '[AutoChmod] Error: Cannot change permissions: ' l:error_msg
        echohl None
        return
    endif

    let s:got_working_passwd = 1

endfunction

function! autochmod#BufWritePost()
    " Restore permissions
    let l:file = expand('%')
    call system('sudo -S chmod o-w -- ' . l:file, s:passwd)
endfunction
