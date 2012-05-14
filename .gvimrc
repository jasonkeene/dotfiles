" disable menu icons in macvim
set guioptions-=T

" disable left and right scrollbars
set guioptions-=L
set guioptions-=r

" set font to something purdy
if has("x11")
    set guifont=Monaco\ 10
else
    set guifont=Monaco:h10
endif

" source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .gvimrc source $MYGVIMRC
endif
