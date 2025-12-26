#!/usr/bin/env bash

## Shell options

shopt -s extglob
shopt -s globstar

## Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vim='nvim'

if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

## Shell prompt

eval "$(starship init bash)"

## Functions

cdf() {
    cd "$(fd -H -I -t d . ${1:-$HOME} | fzf)"
}

## Rbenv

if command -v rbenv >/dev/null 2>&1; then
    # Initialize rbenv
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
