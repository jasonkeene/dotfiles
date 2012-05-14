
# If not running interactively, don't do anything

[ -z "$PS1" ] && return


# platform specific script

platform_script=~/.bash_`uname | awk '{ print tolower($0) }'`
[ -f $platform_script ] && . $platform_script


# python

export PYTHONSTARTUP=~/.pythonrc.py
export PYTHONDONTWRITEBYTECODE=1 # don't write pyc/pyo


# virtualenv

export VIRTUALENV_DISTRIBUTE=1
export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
[ `which virtualenvwrapper.sh` ] && . virtualenvwrapper.sh
alias mkvirtualenv2.6="mkvirtualenv -p python2.6"


# add .local stuff to path

export PATH=~/.local/bin:$PATH


# prompt

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
export PS1="\n\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\H\[\033[00m\]\n\[\033[01;34m\]\w\[\033[00m\]\\n$ "


# terminal colors

TERM=xterm-256color


# history

shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize # update window size LINES and COLUMNS


# aliases

. ~/.bash_aliases


# PANDA!!!!

cat /etc/motd | pandasay
