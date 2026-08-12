[[ $- != *i* ]] && return

#export LC_ALL=C.UTF-8

export EDITOR='emacsclient -c -a ""'
alias emacs='emacsclient -c -a ""'
alias ytns='yt-dlp --sponsorblock-remove all'
alias fetch='$HOME/Thirdparty/fetch/fetch'
alias cls='clear'
alias e='emacs'
export GPG_TTY=$(tty)
alias ls="ls --color=auto"
alias tree="tree -C"
alias grep="grep --color=auto"
alias ll="ls -larth"
bind -f ~/.inputrc
bind '"\C-x\ee":"emacs\C-m"'

if [ "$TERM" = "st-256color" ]; then
    if [ -z "$TMUX" ]; then
	exec tmux new-session -A -s st
    fi
fi

ytsdl() {
    ytns --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1"
}

kpc() {
    keepassxc-cli open ~/Documents/passwords.kdbx
}

ytsearch() {
    yt-dlp --no-download --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null; cat search.txt; rm search.txt
}

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups

shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

PS1='[\u@\h \W]\$ '

[[ $- == *i* ]] && return
