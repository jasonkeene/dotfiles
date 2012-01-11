#!/bin/bash

DOTFILES=".vim .vimrc"
REPO_PATH=`dirname $0`

for DOTFILE in $DOTFILES; do
    if [ -e ~/$DOTFILE ]; then
        echo ~/$DOTFILE already exists
    else
        ln -s $REPO_PATH/$DOTFILE ~/$DOTFILE
    fi
done
