#!/usr/bin/env bash

## Shell options

shopt -s extglob
shopt -s globstar
shopt -s autocd
shopt -s cdspell

## Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vim='nvim'
alias ll='ls -Flath'
alias l='ls -Flth'
alias la='ls -A'
alias ga='git add -A'
alias gl='git log --decorate --graph'
alias gc='git commit -a'
alias gp='git push'
alias gP='git pull'
alias gf='git fetch'
alias gs='git status'
alias gst='git stash'

if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

## Shell prompt

eval "$(starship init bash)"

## Functions

cdf() {
    cd "$(fd -H -I -t d . ${1:-$HOME} | fzf)"
}

# Check if 'pkg' exists, otherwise use 'sudo apt'
APT_CMD() {
    if command -v pkg >/dev/null 2>&1; then
        echo pkg
    else
        echo "sudo apt"
    fi
}

# Update & Upgrade
aptup() {
    CMD=$(APT_CMD)
    if [ "$CMD" = "pkg" ]; then
        $CMD up
    else
        $CMD update && $CMD upgrade
    fi
}

# Upgrade only
aptupg() {
    CMD=$(APT_CMD)
    if [ "$CMD" = "pkg" ]; then
        $CMD upgrade
    else
        $CMD upgrade
    fi
}

# Update only
aptupd() {
    CMD=$(APT_CMD)
    if [ "$CMD" = "pkg" ]; then
        $CMD update
    else
        $CMD update
    fi
}

# Install package(s)
aptin() {
    CMD=$(APT_CMD)
    $CMD install "$@"
}

# Remove package(s)
aptrm() {
    CMD=$(APT_CMD)
    $CMD remove "$@"
}

# Search packages
aptsr() {
    CMD=$(APT_CMD)
    $CMD search "$@"
}

## Rbenv

if command -v rbenv >/dev/null 2>&1; then
    # Initialize rbenv
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
