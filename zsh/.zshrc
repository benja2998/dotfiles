#!/usr/bin/env zsh

## Environment variables

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

## Shell options

# Globbing
setopt EXTENDED_GLOB
setopt GLOBSTAR_SHORT

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
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

bindkey -v

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

VIMODE="(i)"

function zle-keymap-select {
	case $KEYMAP in
		vicmd) VIMODE="(n)" ;;
		viins|main) VIMODE="(i)" ;;
		*) VIMODE="(?)" ;;
	esac
	zle reset-prompt
}

function zle-line-init {
	zle-keymap-select
}

zle -N zle-keymap-select
zle -N zle-line-init

autoload -Uz vcs_info
setopt prompt_subst

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'

function zsh_prompt_error {
	if [[ $? -ne 0 ]]; then
		echo "%F{red}x%f"
		else
			echo "%F{yellow}->%f"
	fi
}

PROMPT=$'\n''%F{cyan}${VIMODE}%f %F{blue}%~%f %F{magenta}${vcs_info_msg_0_}%f'$'\n''$(zsh_prompt_error) '

## Homebrew

if [[ -d /opt/homebrew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local/Homebrew ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
elif [[ -d /home/linuxbrew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
