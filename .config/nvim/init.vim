" Mappings {{{1
let mapleader = ' '

nnoremap <C-J> :execute (getqflist() == [] ? 'l' : 'c') . 'next'<CR>
nnoremap <C-K> :execute (getqflist() == [] ? 'l' : 'c') . 'previous'<CR>
nnoremap ZA :wqall<CR>
nnoremap <Leader>m :make<Up><CR>
nnoremap <Leader>o :!xdg-open <C-R><C-F>
nnoremap <Leader>P :write !pandoc -o %:r.pdf<CR>
nnoremap <Leader>c :cd %:h<CR>
nnoremap <Leader>- :cd -<CR>
nnoremap <Leader>b :ls h<CR>:b<Space>
nnoremap <silent> <Leader>p :set opfunc=initvim#replacewithunnamedplus<CR>g@
nnoremap <Leader>B <Cmd>if &background == 'dark' \| set background=light \| else \| set background=dark \| endif<CR>
nnoremap <expr> <Leader><Leader> ":nmap <" . "Leader><CR>"

" Ex mode maps
cnoremap <M-h> <C-Left>
cnoremap <M-l> <C-Right>
cnoremap <M-j> <End>
cnoremap <M-k> <Home>

" Repurpose default bindings
nnoremap S :%s//g<Left><Left>
nnoremap Y y$
noremap p ]p
noremap P ]P
noremap ]p p
noremap ]P P
noremap c "cc
ounmap c


noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
noremap ]] j0[[%/{<CR>
noremap [] k$][%?}<CR>
" Plugins {{{1
call plug#begin(stdpath('data') . '/vim-plug')
let g:plug_window = 'topleft new'

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-eunuch'
if $SUDO_ASKPASS == ""
    let $SUDO_ASKPASS = '/usr/bin/ssh-askpass'
endif

Plug  'vim-syntastic/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

Plug  'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-vinegar'

Plug  'takac/vim-hardtime'
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 3
let g:list_of_normal_keys = ["h", "j", "k", "l"]

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'tomlion/vim-solidity'

Plug 'mikelue/vim-maven-plugin'

Plug 'yegappan/taglist'
nnoremap <Leader>t :TlistOpen<CR>

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
set formatoptions-=o
" }}}

iabbrev :vim-clean: vim:nu&:rnu&:list&:cc&:noru:ls=0:
cabbrev PDF %:r.pdf

if isdirectory('.git') && empty(argv())
    call initvim#GitSess()
endif
command! Trailspace :%s/ \+$//

command! -nargs=+ -complete=file Badd call initvim#badd(<f-args>)
command! -nargs=0 Presentation call initvim#present()

" Autocommands {{{1
let g:reload_configs = 1
augroup ReloadConfigs
    au!

    autocmd BufWritePost ~/.config/i3status/config call reload_configs#i3status()
    autocmd BufWritePost ~/.config/i3/config call reload_configs#i3()
    autocmd BufWritePost ~/.config/sxhkd/* call reload_configs#sxhkd()
    autocmd BufWritePost ~/.config/nvim/init.vim call reload_configs#vim()
    autocmd BufWritePost ~/.config/systemd/user/* call reload_configs#systemd()
    autocmd BufWritePost ~/.config/tmux/config.tmux call reload_configs#tmux()
augroup END

augroup WhereILeftOf
    au!

    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    autocmd BufWinEnter init.vim normal! zv
augroup END

augroup AutosaveSessions
    au!

    autocmd BufEnter,VimLeave * if v:this_session != ''
                \| mksession!
                \| endif
augroup END
