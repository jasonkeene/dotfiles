
# convenience stuff
if [ `uname` == 'Darwin' ]; then
    alias ls="ls -G"
else
    alias ls="ls --color"
fi
alias la="ls -laF"
alias lt='la -t | head'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less -FRSX'
alias reset="deactivate; cd; clear"
alias nmap="nmap -A -T4"
[ ! "`which gvim`" ] && [ "`which mvim`" ] && alias gvim=mvim
alias mate=gvim
alias vim=gvim
[ ! "`which pbcopy`" ] && [ "`which xclip`" ] && alias pbcopy='xclip -selection clipboard'
[ ! "`which pbpaste`" ] && [ "`which xclip`" ] && alias pbpaste='xclip -selection clipboard -o'
[ "`which gnome-open`" ] && alias open='gnome-open'
alias diff='diff -u'
[ "`which colordiff`" ] && alias diff='colordiff -u'


# git
alias gst="git st"
alias gs="git st"
alias gcm="git co master"
alias gdi="git di"
alias gdc="git dc"
alias gaa="git aa"
alias gmm="git mm"
alias gfa="git fa"
alias gpom="git pom"


# pandasay
alias pandasay="cowsay -f ~/.cowsay/panda.cow"
