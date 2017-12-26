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

" vim-go
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
"let g:go_auto_sameids = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
let g:go_list_type = "quickfix"
set updatetime=100 " updates :GoInfo faster

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|vagrant)|node_modules)$',
  \ 'file': '\v\.(swp|zip|exe|so|dll|a)$',
  \ }

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
"highlight NonText guifg=#4a4a59
highlight NonText ctermfg=239
"highlight SpecialKey guifg=#4a4a59
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

" automatically write file when calling out to make
set autowrite

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

" remove the need to hit c-w for navigating splits
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l


" make W the same as w in case of typo
:command W w

" vim-go command shortcuts
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>d :GoDeclsDir<CR>
autocmd FileType go nmap <leader>g <Plug>(go-generate)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

function! s:toggle_coverage()
    call go#coverage#BufferToggle(!g:go_jump_to_error)
    highlight ColorColumn ctermbg=235
    highlight NonText ctermfg=239
    highlight SpecialKey ctermfg=239
    highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
endfunction

autocmd FileType go nmap <leader>c :<C-u>call <SID>toggle_coverage()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
