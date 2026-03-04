alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias emacs='emacsclient -c -a ""'
alias e='emacsclient -c -a "" ~'
HISTSIZE=50000
HISTFILESIZE=50000
[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)" || true
export PS1="\[\e[1;34m\]\w\[\e[m\] \n\[\e[1;32m\]❯\[\e[m\] "
export GPG_TTY=$(tty)
