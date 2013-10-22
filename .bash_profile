
# login shell or osx non-login shell, just run .bashrc
[ -f ~/.bashrc ] && . ~/.bashrc


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
