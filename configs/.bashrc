[[ $- != *i* ]] && return

# Keybinds will only work in vi mode

export LC_ALL=C.UTF-8

export EDITOR='vis'
alias cls='clear'
alias gls='git log  --show-signature'
alias gl='git log '
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
bind '"\C-f":"tmux-session\C-m"'
bind '"\C-p":"tmux-proj\C-m"'
bind '"\C-e":"ff\C-m"'
bind '"\C-n":"tmux-notes\C-m"'
bind '"\C-t":"tmux-trd\C-m"'
bind '"\C-x":"tmux-newproj\C-m"'

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

cdf() {
    cd "$(find -type d  -not -path '*/.git/*' | vis-menu -l 20 -i)" || true
    cls
}

ff() {
    file="$(find -type f -not -path '*/.git/*' | vis-menu -l 20 -i)"
    if [ -z "$file" ]; then
        return
    fi
    vis "$file"
    cls
}

ytsearch() {
    rm search.txt
    yt-dlp --no-download --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
    cat search.txt
}

ytsdl() {
    rm search.txt
    ytns --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
    cat search.txt
}

tmux-session() {
    local SESS="$(find -type d  -not -path '*/.git/*' | vis-menu -l 20 -i)"
    if [ -z "$SESS" ]; then
        echo No directory
        return
    fi
    local EXST=0
    local SESN="$(basename $SESS | sed 's/\./_/g')"
    if tmux has-session -t "=$SESN" 2>/dev/null; then
        EXST=1
    else
        EXST=0
    fi

    # Now actually do the stuff
    if [ -z "$TMUX" ]; then
        if [ "$EXST" = 1 ]; then
            tmux attach-session -t $SESN
        else
            tmux new-session -d -s $SESN
            tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

            tmux attach-session -t $SESN
        fi
    fi
    cls
}

tmux-proj() {
    local SESS="$(find ~/Projects -mindepth 1 -maxdepth 1 -type d | vis-menu -l 20 -i)"
    if [ -z "$SESS" ]; then
        echo No directory
        return
    fi
    local EXST=0
    local SESN="$(basename $SESS)"
    local SESN="$(basename $SESS | sed 's/\./_/g')"
    if tmux has-session -t "=$SESN" 2>/dev/null; then
        EXST=1
    else
        EXST=0
    fi

    # Now actually do the stuff
    if [ -z "$TMUX" ]; then
        if [ "$EXST" = 1 ]; then
            tmux attach-session -t $SESN
        else
            tmux new-session -d -s $SESN
            tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

            tmux attach-session -t $SESN
        fi
    fi
    cls
}

tmux-trd() {
    local SESS="$(find ~/Thirdparty -mindepth 1 -maxdepth 1 -type d | vis-menu -l 20 -i)"
    if [ -z "$SESS" ]; then
        echo No directory
        return
    fi
    local EXST=0
    local SESN="$(basename $SESS)"
    local SESN="$(basename $SESS | sed 's/\./_/g')"
    if tmux has-session -t "=$SESN" 2>/dev/null; then
        EXST=1
    else
        EXST=0
    fi

    # Now actually do the stuff
    if [ -z "$TMUX" ]; then
        if [ "$EXST" = 1 ]; then
            tmux attach-session -t $SESN
        else
            tmux new-session -d -s $SESN
            tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

            tmux attach-session -t $SESN
        fi
    fi
    cls
}

tmux-newproj() {
    local SESS trd base thelastone
    read -r -p "Git URL (<url>/new): " url
    read -r -p "Third party? (y/n): " trd

    if [ -z "$url" ] || [ -z "$trd" ]; then
        echo No
        return
    fi

    if [ "$trd" = "y" ]; then
        base="$HOME/Thirdparty"
    else
        base="$HOME/Projects"
    fi

    thelastone="$(pwd)"

    cd "$base"

    if [ "$url" = new ]; then
        read -r -p "Repo name: " name
        if [ -z "$name" ]; then
            return
        fi
        mkdir -p "$name"
        cd "$name"
        git init
        SESS="$(pwd)"
    else
        git clone "$url"
        SESS="$(pwd)/$(basename $url | sed 's/\.git$//g')"
    fi

    if [ "$SESS" = "$base/" ]; then
        cd -
        return
    fi

    cd "$thelastone"

    if [ -z "$SESS" ]; then
        echo No directory
        return
    fi
    local EXST=0
    local SESN="$(basename $SESS)"
    local SESN="$(basename $SESS | sed 's/\./_/g')"
    if tmux has-session -t "=$SESN" 2>/dev/null; then
        EXST=1
    else
        EXST=0
    fi

    # Now actually do the stuff
    if [ -z "$TMUX" ]; then
        if [ "$EXST" = 1 ]; then
            tmux attach-session -t $SESN
        else
            tmux new-session -d -s $SESN
            tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

            tmux attach-session -t $SESN
        fi
    fi
    cls
}

tmux-notes() {
    local SESS="$HOME/Documents/Notes"
    local EXST=0
    local SESN="$(basename $SESS)"
    local SESN="$(basename $SESS | sed 's/\./_/g')"
    if tmux has-session -t "=$SESN" 2>/dev/null; then
        EXST=1
    else
        EXST=0
    fi

    # Now actually do the stuff
    if [ -z "$TMUX" ]; then
        if [ "$EXST" = 1 ]; then
            tmux attach-session -t $SESN
        else
            tmux new-session -d -s $SESN
            tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

            tmux attach-session -t $SESN
        fi
    fi
}

[[ $- == *i* ]] && return
