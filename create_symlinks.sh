#!/bin/bash

if [ -n "${DOTFILES:-x}" ]; then
    DOTFILES=".vim .vimrc .gvimrc .bash_aliases .bash_profile .pythonrc.py"
done
if [ -n "${DIRNAME:-x}" ]; then
    DIRNAME=`dirname $0`
done
if [ -n "${REPO_PATH:-x}" ]; then
    REPO_PATH=`cd $DIRNAME; pwd`
done

for DOTFILE in $DOTFILES; do
    if [ -e ~/$DOTFILE ]; then
        echo ~/$DOTFILE already exists
    else
        ln -s $REPO_PATH/$DOTFILE ~/$DOTFILE
    fi
done
