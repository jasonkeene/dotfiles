
# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# platform specific script comes first!
platform_script="$HOME/.bash_$(uname | awk '{ print tolower($0) }')"
[ -f "$platform_script" ] && . "$platform_script"
unset platform_script

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
fi

# shell prompt
function current_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$([[ $(git status --porcelain 2> /dev/null) ]] && echo "*")]/"
}
export PS1="\n\
\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\H\[\033[00m\] \$(current_git_branch)\n\
\[\033[01;34m\]\w\[\033[00m\]\\n\
$ "

# terminal colors
TERM=xterm-256color

# use vim as default editor
export EDITOR=$(which vim)

# history
shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkwinsize # update window size LINES and COLUMNS

# include aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# direnv
[ "$(which direnv)" ] && eval "$(direnv hook bash)"

# pandasay
if type pandasay &> /dev/null; then
    cat /etc/motd | pandasay
else
    cat /etc/motd
fi

# gcloud
function gcloud {
    if ! docker inspect gcloud-config > /dev/null 2>&1; then
        docker run -it --name gcloud-config google/cloud-sdk:alpine gcloud auth login
    fi
    docker run -it --rm --volumes-from gcloud-config google/cloud-sdk:alpine gcloud $@
}

# k8s
. <(kubectl completion bash)

# local path
export PATH=$HOME/.local/bin:$PATH

# local bashrc
[ -f ~/.bash_local ] && . ~/.bash_local
