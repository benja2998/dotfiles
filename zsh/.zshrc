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
alias e='emacs .'           # Open emacs in current directory

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

export LANG=C.UTF-8
export LANGUAGE=C.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=C.UTF-8
export LC_NUMERIC=C.UTF-8
export LC_TIME=C.UTF-8
export LC_COLLATE=C.UTF-8
export LC_MONETARY=C.UTF-8
export LC_MESSAGES=C.UTF-8
export LC_PAPER=C.UTF-8
export LC_NAME=C.UTF-8
export LC_ADDRESS=C.UTF-8
export LC_TELEPHONE=C.UTF-8
export LC_MEASUREMENT=C.UTF-8
export LC_IDENTIFICATION=C.UTF-8
