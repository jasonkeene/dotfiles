
# if not running interactively, don't do anything
[ -z "$PS1" ] && return


# platform specific script comes first!
platform_script=~/.bash_`uname | awk '{ print tolower($0) }'`
[ -f $platform_script ] && . $platform_script
unset platform_script


# add .local stuff to path
# TODO I don't really use this so maybe think about removing it
export PATH=~/.local/bin:$PATH


# python
[ -f ~/.pythonrc.py ] && export PYTHONSTARTUP=~/.pythonrc.py
export PYTHONDONTWRITEBYTECODE=1 # don't write pyc/pyo
export VIRTUALENV_DISTRIBUTE=1 # use distribute w/ virtualenvs
if which virtualenvwrapper.sh-2.7 &> /dev/null; then
    # use virtualenvwrapper
    export WORKON_HOME=~/.virtualenvs
    export PROJECT_HOME=~/projects
    [ -d $WORKON_HOME ] && mkdir -p $WORKON_HOME
    . virtualenvwrapper.sh-2.7
    alias mkvirtualenv2.6="mkvirtualenv -p python2.6"
fi


# shell prompt
# TODO just pulled this out of debian bashrc with slight modifications
#      works well on the mac but might want to generalize it
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
function current_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$([[ `git status --porcelain 2> /dev/null` ]] && echo "*")]/"
}
export PS1="\n\
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\H\[\033[00m\] \$(current_git_branch)\n\
\[\033[01;34m\]\w\[\033[00m\]\\n\
$ "


# terminal colors
TERM=xterm-256color


# use bare vim as default editor from the command line
# use `which vim` cus osx's default vim is trash
export EDITOR=`which vim`


# set bash vi mode
set -o vi


# history
shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize # update window size LINES and COLUMNS


# include aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases


# PANDA!!!!
if type pandasay &> /dev/null; then
    cat /etc/motd | pandasay
else
    cat /etc/motd
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
