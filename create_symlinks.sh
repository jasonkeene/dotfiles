#!/bin/bash

if [ ! "$DOTFILES" ]; then
    DOTFILES=".cowsay .vim .vimrc .gvimrc .bash_aliases .bash_darwin .bash_linux .bash_profile .bashrc .pythonrc.py .gitconfig .hgrc"
fi
if [ ! "$REPO_PATH" ]; then
    DIRNAME=`dirname $0`
    REPO_PATH=`cd $DIRNAME; pwd`
fi

for DOTFILE in $DOTFILES; do
    if [ -e ~/$DOTFILE ]; then
        echo ~/$DOTFILE already exists
    else
        ln -s $REPO_PATH/$DOTFILE ~/$DOTFILE
    fi
done
