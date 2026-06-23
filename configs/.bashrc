export EDITOR='emacsclient -c -a ""'
alias emacs='emacsclient -c -a ""'
alias ls="ls -B --color=auto"
alias tree="tree -C"
alias grep="grep --color=auto"
alias fastfetch="fastfetch -c examples/13"

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s cdspell
shopt -s autocd
shopt -s checkwinsize

eval "$(starship init bash)"

[[ $- == *i* ]] && return
