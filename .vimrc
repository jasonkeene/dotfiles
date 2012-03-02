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
