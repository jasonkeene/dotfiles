" disable menu icons in macvim
set guioptions-=T

" set font to something purdy
set guifont=Monaco:h10

" source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .gvimrc source $MYGVIMRC
endif
