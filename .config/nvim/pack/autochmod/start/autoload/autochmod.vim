
function! s:Error(string)
    echohl Error
    echo '[AutoChmod] Error: ' . a:string
    echohl None
endfunction

" Tries to get the password from user input and put it in s:passwd
" Returns true if the correct password is in s:passwd
function! s:AskPass()
    while !exists('s:passwd')
        let s:passwd = inputsecret('[AutoChmod] enter password: ')
        echo "\n"

        if empty(s:passwd)
            unlet s:passwd
            return v:false
        endif

        " Test password
        let l:error_msg = system('LC_ALL=C sudo -Sp "" :', s:passwd)
        if match(l:error_msg, 'incorrect password attempt') != -1
            call s:Error('incorrect password')
            unlet s:passwd
        endif
    endwhile
    return v:true
endfunction



function! autochmod#PromptAndChmod()
    let l:file = expand('%')

    " Should restore these afterwards..
    set nobackup nowritebackup

    if !s:AskPass()
        return
    endif
    " Change permissions
    let s:stats = system('sudo -Sp "" stat -c%a -- ' . l:file, s:passwd)
    let s:stats = substitute(s:stats, '\n$', '', '')
    if v:shell_error
        let l:error_msg = system('sudo -Sp "" touch -- ' . l:file, s:passwd)
        if v:shell_error
            call s:Error('Non-existing file is not touchable: ' . l:error_msg)
            let s:dont_process = 1
            return
        endif
    endif
    let l:error_msg = system('sudo -Sp "" chmod a+w -- ' . l:file, s:passwd)
    if v:shell_error
        call s:Error('Cannot change permissions: ' . l:error_msg)
        return
    endif
endfunction



function! autochmod#ChmodBack()
    " Restore permissions
    let l:file = expand('%')
    if exists('s:dont_process')
        unlet s:dont_process
        return
    endif
    if exists('s:passwd')
        if !exists('s:stats')
            call s:Error('No stats to change back to given')
            return
        endif
        let l:error_msg = system('sudo -Sp "" chmod ' . s:stats . ' -- ' . l:file, s:passwd)
        if v:shell_error
            call s:Error("Couldn't change permissions back: " . l:error_msg)
        endif
    endif
endfunction
