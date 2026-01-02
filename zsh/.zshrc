#!/usr/bin/env zsh

## Shell options

# Globbing
setopt EXTENDED_GLOB
setopt GLOBSTAR_SHORT

# Command correction
setopt CORRECT
setopt CORRECT_ALL

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ZLE highlight and word characters
zle_highlight=('paste:none')
WORDCHARS=${WORDCHARS//\/}

# Timeout
KEYTIMEOUT=25

## Keybindings

TRAPWINCH() {
    zle reset-prompt
}

zmodload zsh/complist
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'l' forward-char

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search

bindkey -v

bindkey -M viins 'jj' vi-cmd-mode

## Aliases

alias ls='ls --color=auto'
alias tree='tree -C'
alias gtree='git ls-files | tree -a --fromfile'
alias q='exit'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vim='nvim'
alias v='nvim'
alias t='tmux'
alias ll='ls -FAlth'
alias c='clear'
alias s='source ~/.zshrc'
alias l='ls -Flth'
alias la='ls -A'

# Git shortcuts
alias ga='git add -A'
alias g='git'
alias gl='git log --decorate --graph'
alias gc='git commit -a'
alias gp='git push'
alias gP='git pull'
alias gf='git fetch'
alias gs='git status'
alias gst='git stash'
alias gb='git branch'
alias gbl='git blame'
alias gba='git branch -a'
alias gfm='git ls-files -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gls='git log --oneline --graph --decorate --all'
alias gd='git diff --staged'
alias gds='git diff'
alias gcu='git reset --soft HEAD~1'
alias gcln='git clean -fd'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias grb='git rebase master'
alias grbi='git rebase -i'
alias gmg='git merge'
alias gmgf='git merge --ff-only'
alias gshow='git show'
alias gtag='git tag'
alias gtags='git tag -l'
alias gundo='git reset --hard HEAD'
alias gpl='git pull --rebase'
alias gcount='git shortlog -sn'
alias gwho='git log --pretty=format:"%an" | sort | uniq -c | sort -nr'
alias gdf='git diff --name-only'
alias glg='git log --stat'
alias gclean='git reset --hard && git clean -fd'

# fd/fdfind alias
if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

## Prompt

eval "$(starship init zsh)"

## Functions

# Fuzzy find directories
cdf() {
    cd "$(fd -H -I -t d . "${1:-$HOME}" | fzf)" || return
}

## Rbenv

if command -v rbenv >/dev/null 2>&1; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - zsh)"
fi

## Linuxbrew

[[ -d /home/linuxbrew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" || true
