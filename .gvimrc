" disable menu icons in macvim
set guioptions-=T

" source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .gvimrc source $MYGVIMRC
endif
