#!/bin/bash

DOTFILES=".vim .vimrc .gvimrc .bash_aliases .bash_profile .pythonrc.py"
DIRNAME=`dirname $0`
REPO_PATH=`cd $DIRNAME; pwd`

for DOTFILE in $DOTFILES; do
    if [ -e ~/$DOTFILE ]; then
        echo ~/$DOTFILE already exists
    else
        ln -s $REPO_PATH/$DOTFILE ~/$DOTFILE
    fi
done
