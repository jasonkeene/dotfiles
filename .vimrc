" break with the busted old vi junk
" must be first, as it changes other options as a side effect
set nocompatible

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

" source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
