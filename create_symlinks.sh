#!/bin/bash

DOTFILES=".vim .vimrc .gvimrc"
DIRNAME=`dirname $0`
REPO_PATH=`cd $DIRNAME; pwd`

for DOTFILE in $DOTFILES; do
    if [ -e ~/$DOTFILE ]; then
        echo ~/$DOTFILE already exists
    else
        ln -s $REPO_PATH/$DOTFILE ~/$DOTFILE
    fi
done
