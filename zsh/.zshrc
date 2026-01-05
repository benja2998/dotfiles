#!/usr/bin/env zsh

## Environment variables

export PATH="$HOME/.local/bin:$HOME/neovim/bin:$HOME/.cargo/bin:$HOME/.local/share/bob/nvim-bin:$PATH"

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
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search

bindkey -v

## Aliases

alias ls='ls --color=auto'
alias tree='tree -C'
alias gtree='git ls-files | tree -a --fromfile'
alias q='exit'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
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
		echo "%F{#f38ba8}✗%f"
		else
			echo "%F{#f9e2af}➜%f"
	fi
}

PROMPT=$'\n''%F{#181825}%f%K{#181825} %F{#b4befe}${VIMODE}%f %F{#cba6f7}%~%f %F{#f5c2e7}${vcs_info_msg_0_}%f %k%F{#181825}%f'$'\n''$(zsh_prompt_error) '

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

## Homebrew

if [[ -d /opt/homebrew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local/Homebrew ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
elif [[ -d /home/linuxbrew ]]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

## Plugins

if [[ ! -d "$HOME/.zsh-syntax-highlighting" ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting"
fi

source "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
