## Translated from bash/.bashrc by Claude

# Only run in interactive shells
[[ $- != *i* ]] && return

# Shell options
setopt APPEND_HISTORY        # Append to history rather than rewriting
setopt AUTO_CD               # Allow changing to a directory without cd
setopt GLOB_STAR_SHORT       # Allow using **
setopt EXTENDED_GLOB         # Advanced globbing

# Aliases
alias ls='ls --color=auto'   # Colored directory listings
alias grep='grep --color=auto'   # Colored grep
alias egrep='egrep --color=auto' # Colored egrep
alias emacs='emacsclient -c -a ""'         # Emacs
alias e='emacsclient -c -a "" .'           # Open emacs in current directory

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000               # Allow in-memory history to be very big
SAVEHIST=50000               # Allow history file to be very big
setopt SHARE_HISTORY         # Shared history across sessions (replaces PROMPT_COMMAND equivalent)
setopt HIST_IGNORE_ALL_DUPS  # Erase duplicate entries

# Prompt
export PS1="[%n@%m %1~]%# " # [user@localhost somefolder]$

# Paths and env
export PATH="$HOME/.local/bin:$PATH"         # User binaries
export EDITOR='emacsclient -c -a "" -w'      # Emacs as default editor

# Machine-specific settings
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Homebrew (macOS)
[[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
[[ -f "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"        # Intel Mac

# Fuzzy find directories and commands
eval "$(fzf --zsh)"
