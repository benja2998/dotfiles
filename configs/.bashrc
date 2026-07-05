[[ $- != *i* ]] && return

export LC_ALL=C.UTF-8

export EDITOR='vim'
alias code='code-oss'
export GPG_TTY=$(tty)
alias ls="ls -B --color=auto"
alias tree="tree -C"
alias grep="grep --color=auto"
alias ll="ls -larth"

bind '"\C-f":"cdf\C-j"'

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s cdspell
shopt -s globstar
shopt -s extglob
shopt -s autocd
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

cdf() {
	cd "$(find -type d | fzf)" || true
}

[[ $- == *i* ]] && return
