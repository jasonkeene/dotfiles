" break with the busted old vi junk
" must be first, as it changes other options as a side effect
set nocompatible

" show line numbers
set number

" enable syntax highlighting
syntax on

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

" need this to highlight python builtins
let python_highlight_all = 1

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
