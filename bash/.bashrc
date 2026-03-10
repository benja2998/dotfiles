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
shopt -s histappend
shopt -s autocd
shopt -s globstar
shopt -s cdspell
shopt -s checkwinsize
PROMPT_COMMAND="history -a; history -c; history -r"
eval "$(fzf --bash)"
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
