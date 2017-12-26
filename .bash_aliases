
if [ "$(uname)" = "Darwin" ]; then
    alias ls="ls -G"
else
    alias ls="ls --color"
fi
alias grep="grep --color=auto"
alias pandasay="cowsay -f ~/.cowsay/panda.cow"
