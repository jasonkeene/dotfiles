
# server aliases

if [ -f ~/.bash_server_aliases ]; then
    . ~/.bash_server_aliases
fi


# convenience stuff

alias ls="ls -laG"
alias reset="deactivate; cd; clear"
alias nmap="nmap -A -T4"


# pandasay

alias pandasay="cowsay -f panda"


# pyquality

pyquality_install () {
    pip install pep8 pyflakes pylint http://softlayer.dl.sourceforge.net/project/pychecker/pychecker/0.8.19/pychecker-0.8.19.tar.gz
}
pyquality_runner () {
    PEP8="pep8 $@"
    PYCHECKER="pychecker $@"
    PYFLAKES="pyflakes $@"
    PYLINT="pylint -f colorized -r no $@"
    
    if [[ `$PEP8 2> /dev/null` != "" ]]
    then
        echo -e "\n\033[0;31m  pep8:  \033[0m\n"
        $PEP8
    fi
    if [[ `$PYCHECKER 2> /dev/null` != "" ]]
    then
        echo -e "\n\033[0;31m  pychecker:  \033[0m\n"
        $PYCHECKER
    fi
    if [[ `$PYFLAKES 2> /dev/null` != "" ]]
    then
        echo -e "\n\033[0;31m  pyflakes:  \033[0m\n"
        $PYFLAKES
    fi
    if [[ `$PYLINT 2> /dev/null` != "" ]]
    then
        echo -e "\n\033[0;31m  pylint:  \033[0m\n"
        $PYLINT
        echo
    fi
}
pyquality () {
    pyquality_runner "$@" 2>&1 | less -FRSXd
}


# pushd stuff (i no longer use this)

# alias dirs='dirs -v'
# alias d='dirs'
# grab_args() {
#     cmd=$1
#     shift
#     $cmd "$@" > /dev/null
#     status=$?
#     if [ $status -eq 0 ]
#     then
#         dirs
#     fi
#     return $status
# }
# export -f grab_args
# alias popd='grab_args popd'
# alias pushd='grab_args pushd'
# alias pd='pushd'