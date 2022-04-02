setlocal errorformat=%f\|%l\ col\ %c\|%m
setlocal modifiable
nnoremap <buffer> <Space>c :cgetbuffer<CR>:q<CR>
nnoremap <buffer> <Space>l :lgetbuffer<CR>:q<CR>
