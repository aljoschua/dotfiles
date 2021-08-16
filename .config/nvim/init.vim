" vim:fdm=marker:
if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

" Options {{{1
" File management
set nobackup undofile hidden
set path-=/usr/include path+=**

" Tab Usage
set tabstop=4 shiftwidth=4 expandtab softtabstop=4

set number relativenumber

" Display blanks
set showbreak=↪\  list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲,conceal:␣
highlight SpecialKey ctermfg=red

" Misc.
set colorcolumn=81 cursorline
set background=dark
set clipboard=unnamedplus

" Mappings {{{1
let mapleader = ' '

nnoremap <C-J> :cnext<CR>
nnoremap <C-K> :cprevious<CR>
nnoremap ZA :wqall<CR>
nnoremap <leader>m q:?^make<CR><CR>
nnoremap <leader>l :!xdg-open <C-R><C-F><CR>
nnoremap <leader>p :write !pandoc -o %:r.pdf<CR>


" map [[ ?{<CR>w99[{
" map ][ /}<CR>b99]}
" map ]] j0[[%/{<CR>
" map [] k$][%?}<CR>
" }}}

iabbrev :vim-clean: vim:nu&:rnu&:list&:cc&:noru:ls=0:

command! Gitsess :call initvim#GitSess()

" Autocommands {{{1
let g:reload_configs = 1
augroup ReloadConfigs
    au!

    autocmd BufWritePost ~/.config/i3status/config
                \ if g:reload_configs | execute '!i3-msg restart' | endif
    autocmd BufWritePost ~/.config/i3/config
                \ if g:reload_configs | execute '!i3-msg reload' | endif
    autocmd BufWritePost ~/.config/sxhkd/*
                \ if g:reload_configs | execute '!systemctl --user reload sxhkd.service' | endif
    autocmd BufWritePost ~/.config/nvim/init.vim
                \ if g:reload_configs | source % | endif
    autocmd BufWritePost ~/.config/systemd/user/*
                \ if g:reload_configs | execute '!systemctl --user daemon-reload' | endif
augroup END

augroup WhereILeftOf
    au!

    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    autocmd BufWinEnter init.vim normal! zv
augroup END

" Plugins {{{1
call plug#begin(stdpath('data') . '/vim-plug')
let g:plug_window = 'topleft new'

Plug  'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

Plug  'tpope/vim-fugitive'

Plug  'takac/vim-hardtime'
let g:hardtime_default_on = 1

Plug stdpath('config') . '/pack/autochmod/start' " Loaded outside of vim-plug
nnoremap <leader>a :call AutoChmodEnable()<CR>

call plug#end()
