" break with the busted old vi junk
" must be first, as it changes other options as a side effect
set nocompatible


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()

" python mode
let g:pymode_lint_checker = "pylint,pyflakes,pep8,mccabe"
let g:pymode_lint_cwindow = 0
let g:pymode_breakpoint_key = '<leader>p'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

" enable syntax highlighting
syntax on

" color scheme
colorscheme lucius

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" store swp files centrally
set dir=~/tmp

" don't backup osx's tmp dir
set backupskip=/tmp/*,/private/tmp/*

" show line numbers
set number

" show lines in lower right
set ruler

" don't wrap lines eva!
set nowrap

" global text columns
set textwidth=78
set formatoptions+=l " don't automatically break long lines less they are new

" highlight col 80
set colorcolumn=80
highlight ColorColumn guibg=gray16
highlight ColorColumn ctermbg=Black

" highlight current line
set cursorline

" invert and bold status line
set highlight=sbr

" highlight search results
set hlsearch

" allow background buffers
set hidden

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

" keep a longer history
set history=1000

" endable folding
set foldmethod=indent
set foldlevel=99

" make file/command tab completion useful
set wildmode=list:longest

" keep cursor somewhat centered
" set scrolloff=25

" clipboard fusion!
set clipboard^=unnamed clipboard^=unnamedplus


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set leader
let mapleader = ","

" switch between files
nnoremap <leader><leader> <c-^>

" run pytest
nnoremap <leader>f <esc>:Pytest file<CR>

" rope stuff
map <leader>g :call RopeGotoDefinition()<CR>
map <leader>d :call RopeShowDoc()<CR>


" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" reselect when indenting
vnoremap < <gv
vnoremap > >gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

    " jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif
