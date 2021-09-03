augroup AutoChmod
    au!

    autocmd BufWritePre * call s:chmodIfNotWritable(function('autochmod#PromptAndChmod'))
    autocmd BufWritePost * call autochmod#ChmodBack()
augroup END

function! s:chmodIfNotWritable(funcref)
    " filewriteable == 0 could still mean that the file doesn't exist but we
    " could create it
    if filewritable(expand('%')) == 0 && filewritable(expand('%:h')) != 2
        call a:funcref()
    endif
endfunction
