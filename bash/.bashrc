alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias emacs='emacsclient -c -a ""'
alias e='emacsclient -c -a "" .'
HISTSIZE=50000
HISTFILESIZE=50000
export PS1="[\u@\h \W]\$ "
export PATH="/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$PATH"
export HISTCONTROL="erasedups:ignoredups"
eval "$(fzf --bash)"
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
