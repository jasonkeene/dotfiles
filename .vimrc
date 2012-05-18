" break with the busted old vi junk
" must be first, as it changes other options as a side effect
set nocompatible

" store swp files centrally
set dir=~/tmp

" don't backup osx's tmp dir
set backupskip=/tmp/*,/private/tmp/*

" show line numbers
set number

" don't wrap lines eva!
set nowrap

" highlight characters past 80 cols
:match ErrorMsg '\%>80v.\+'

" enable syntax highlighting
syntax on

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

" need this to highlight python builtins
let python_highlight_all = 1

" highlight search results
set hlsearch

" allow background buffers
set hidden

" set leader
let mapleader = ","

" key maps
" switch between files
nnoremap <leader><leader> <c-^>
" run pytest
nnoremap <leader>f <esc>:Pytest file<CR>
" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" keep a longer history
set history=1000

" make file/command tab completion useful
set wildmode=list:longest

" pathogen
call pathogen#infect()

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_quiet_warnings = 0
let g:syntastic_python_checker = 'pylint'
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python'],
                           \ 'passive_filetypes': [] }

" activate virtualenv
:python << EOF
import os
virtualenv = os.environ.get('VIRTUAL_ENV')
if virtualenv:
    activate_this = os.path.join(virtualenv, 'bin', 'activate_this.py')
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))
EOF

" color themes
colorscheme lucius

" enable display of invisible characters
set list

" use the same symbols as textmate for tabs and eols
set listchars=tab:▸\ ,eol:¬

" invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" global tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" global text columns
set textwidth=80

" rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" diff with saved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" autocmd stuff
if has("autocmd")
  " source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif
