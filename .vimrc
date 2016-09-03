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

" go vim
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" neocomplete
let g:neocomplete#enable_at_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

" enable syntax highlighting
syntax on

" color scheme
colorscheme lucius

" set 256 color
set t_Co=256

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" store swp files centrally
set dir=~/tmp

" don't backup tmp dirs
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
"highlight ColorColumn guibg=gray16
highlight ColorColumn ctermbg=235

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

" use special symbols for tabs and eols
set listchars=tab:▸\ ,eol:¬

" invisible character colors
highlight NonText guifg=#4a4a59
highlight NonText ctermfg=239
highlight SpecialKey guifg=#4a4a59
highlight SpecialKey ctermfg=239

" global tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" keep a longer history
set history=10000

" endable folding
set foldmethod=syntax
set foldlevel=99

" make file/command tab completion useful
set wildmode=list:longest

" clipboard fusion!
set clipboard^=unnamed clipboard^=unnamedplus

" highlight go-vim
highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set leader
let mapleader = ","

" switch between files
nnoremap <leader><leader> <c-^>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" reselect when indenting
vnoremap < <gv
vnoremap > >gv

:command W w


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
