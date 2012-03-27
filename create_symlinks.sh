#!/bin/bash

if [ ! "$DOTFILES" ]; then
    DOTFILES=".vim .vimrc .gvimrc .bash_aliases .bash_profile .pythonrc.py .gitconfig"
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
