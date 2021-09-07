" vim:fdm=marker:
if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

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
" Options {{{1
" File management
set nobackup undofile hidden
set path-=/usr/include

" Tab Usage
set tabstop=4 shiftwidth=4 expandtab softtabstop=4

set number relativenumber

" Display blanks
set showbreak=↪\  list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲,conceal:␣
highlight SpecialKey ctermfg=red

" Misc.
set colorcolumn=81 cursorline
set clipboard=unnamedplus
set ignorecase smartcase

" Mappings {{{1
let mapleader = ' '

nnoremap <C-J> :cnext<CR>
nnoremap <C-K> :cprevious<CR>
nnoremap ZA :wqall<CR>
nnoremap <leader>m q:?^make<CR><CR>
nnoremap <leader>o :!xdg-open <C-R><C-F>
nnoremap <leader>p :write !pandoc -o %:r.pdf<CR>
nnoremap <leader>c :cd %:h<CR>
nnoremap <leader>- :cd -<CR>
nnoremap S :%s//g<Left><Left>


" map [[ ?{<CR>w99[{
" map ][ /}<CR>b99]}
" map ]] j0[[%/{<CR>
" map [] k$][%?}<CR>
" }}}

iabbrev :vim-clean: vim:nu&:rnu&:list&:cc&:noru:ls=0:
cabbrev PDF %:r.pdf

if isdirectory('.git') && empty(argv())
    call initvim#GitSess()
endif
command! Trailspace :%s/ \+$//

" Autocommands {{{1
let g:reload_configs = 1
augroup ReloadConfigs
    au!

    autocmd BufWritePost ~/.config/i3status/config call reload_configs#i3status()
    autocmd BufWritePost ~/.config/i3/config call reload_configs#i3()
    autocmd BufWritePost ~/.config/sxhkd/* call reload_configs#sxhkd()
    autocmd BufWritePost ~/.config/nvim/init.vim call reload_configs#vim()
    autocmd BufWritePost ~/.config/systemd/user/* call reload_configs#systemd()
    autocmd BufWritePost ~/.config/tmux/config call reload_configs#tmux()
augroup END

augroup WhereILeftOf
    au!

    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    autocmd BufWinEnter init.vim normal! zv
augroup END

