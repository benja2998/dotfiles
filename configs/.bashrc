[[ $- != *i* ]] && return

#export LC_ALL=C.UTF-8

export EDITOR='emacsclient -c -a ""'
alias emacs='emacsclient -c -a ""'
alias cls='clear'
alias gls='git log  --show-signature'
alias gl='git log '
alias gt='git tag'
alias ytns='yt-dlp --sponsorblock-remove all'
alias fetch='$HOME/Thirdparty/fetch/fetch'
alias gs='git status'
alias gsh='git --no-pager show'
alias ga='git add -A'
alias gp='git push'
alias gc='git commit -m'
alias gd='git --no-pager diff'
alias gf='git fetch'
alias gpl='git pull --rebase'
alias gpt='git push --tags'
export GPG_TTY=$(tty)
alias ls="ls --color=auto"
alias tree="tree -C"
alias grep="grep --color=auto"
alias ll="ls -larth"
bind -f ~/.inputrc
bind '"\C-x":"emacs\C-m"' # for termux

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

PS1='[\u@\h \W]\$ '

[[ $- == *i* ]] && return
