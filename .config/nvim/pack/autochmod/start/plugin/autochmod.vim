function! AutoChmodEnable()
    augroup AutoChmod
        au!

        autocmd BufWritePre * call autochmod#BufWritePre()
        autocmd BufWritePost * call autochmod#BufWritePost()
    augroup END
endfunction
