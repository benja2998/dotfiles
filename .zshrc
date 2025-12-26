#!/usr/bin/env zsh

## Shell history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

## Shell options

setopt extended_glob

## Completion

autoload -Uz compinit
compinit -C

## Better tab completion

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' ignore-duplicates yes
bindkey '^[[Z' reverse-menu-complete

## Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vim='nvim'

if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

## Prompt

eval "$(starship init zsh)"

## Functions

cdf() {
    cd "$(fd -H -I -t d . ${1:-$HOME} | fzf)"
}

## Plugin directory

PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$PLUGIN_DIR"

## Autosuggestions

if [[ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$PLUGIN_DIR/zsh-autosuggestions"
fi

source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

## Syntax highlighting

if [[ ! -d "$PLUGIN_DIR/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$PLUGIN_DIR/zsh-syntax-highlighting"
fi

source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

## Rbenv

if command -v rbenv >/dev/null 2>&1; then
    # Initialize rbenv
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
