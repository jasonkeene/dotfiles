
# macports

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# python

export PATH="/Library/Frameworks/Python.framework/Versions/3.2/bin:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PYTHONSTARTUP=~/.pythonrc.py
export PYTHONDONTWRITEBYTECODE=1 # don't write pyc/pyo

# ruby

export PATH="/Users/laocoon/.gem/ruby/1.8/bin:${PATH}"
[[ -s "/Users/laocoon/.rvm/scripts/rvm" ]] && source "/Users/laocoon/.rvm/scripts/rvm" # rvm thing

# java

export PATH="/Users/laocoon/jython2.5.2/bin:${PATH}"

# mysql

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

# git

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    . /usr/local/git/contrib/completion/git-completion.bash
fi

# misc env

export PATH=~/.local/bin:$PATH
export PS1="\n\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\H\[\033[00m\]\n\[\033[01;34m\]\w\[\033[00m\]\\n$ "
export TM_RST2HTML=/Library/Frameworks/Python.framework/Versions/2.6/bin/rst2html.py

# virtualenvwrapper

export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages" # this doesn't appear to work :/
source /Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper.sh
alias mkvirtualenv="mkvirtualenv --no-site-packages"
alias mkvirtualenv2.7="mkvirtualenv -p python2.7 --no-site-packages"

# make c stuff easier to build :D

export CC=gcc-4.2
export ARCHFLAGS='-arch i386 -arch x86_64'

# aliases

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# PANDA!!!!

cat /etc/motd | pandasay
