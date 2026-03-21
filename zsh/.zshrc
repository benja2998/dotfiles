setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"

setopt AUTO_CD
setopt EXTENDED_GLOB
setopt GLOB_STAR_SHORT

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias emacs='emacsclient -c -a ""'
alias e='emacsclient -c -a "" .'

if [[ "$(uname)" = "Darwin" ]]; then
    alias emacs='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -a ""'
    alias e='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -a "" .'
fi

export PROMPT='[%n@%m %1~]%# '

add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "/Applications/Emacs.app/Contents/MacOS/bin"
add_to_path "$HOME/.local/bin"
export EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -a "" -w'

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

[[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(fzf --zsh)"
