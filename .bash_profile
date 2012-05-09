
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


# misc

export PATH=~/.local/bin:$PATH
export PS1="\n\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\H\[\033[00m\]\n\[\033[01;34m\]\w\[\033[00m\]\\n$ "


# aliases

. ~/.bash_aliases


# PANDA!!!!

cat /etc/motd | pandasay
