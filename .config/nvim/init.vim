
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'vim-scripts/bufkill.vim'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ervandew/supertab'

" Plug 'SirVer/ultisnips.git'
" Plug 'honza/vim-snippets.git'

call plug#end()

" completion
set completeopt-=preview
" let g:SuperTabDefaultCompletionType = "<c-n>"
let g:deoplete#enable_at_startup = 1

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|lib|node_modules|src/github.com|src/golang.org|src/gopkg.in|bin|pkg|.vagrant)$',
  \ 'file': '\v\.(swp|zip|exe|so|dll|a)$',
  \ }

" snippets
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" highlight go-vim
highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239

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
" Generic Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
highlight ColorColumn ctermbg=235

" highlight current line
set cursorline

" highlight search results
set hlsearch

" allow background buffers
set hidden

" enable display of invisible characters
set list

" use special symbols for tabs and eols
set listchars=tab:▸\ ,eol:¬

" invisible character colors
highlight NonText ctermfg=239
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

" clipboard fusion!
set clipboard^=unnamed clipboard^=unnamedplus

" automatically write file when calling out to make
set autowrite

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set leader
let mapleader = ","

" switch between files
nnoremap <leader><leader> <c-^>

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

" disallow arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
