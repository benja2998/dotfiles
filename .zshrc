#!/usr/bin/env zsh

## Environment variables

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="vim"

## Shell options

# Globbing
setopt EXTENDED_GLOB
setopt GLOBSTAR_SHORT

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

## Keybindings

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
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

## Aliases

alias ls='ls --color=auto'
alias tree='tree -C'
alias grep='grep --color=auto'
alias dir='dir --color=auto'

# fd/fdfind alias
if command -v fdfind >/dev/null 2>&1; then
	alias fd='fdfind'
fi

## Prompt

PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '

## Homebrew

if [[ -d /opt/homebrew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local/Homebrew ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
elif [[ -d /home/linuxbrew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
