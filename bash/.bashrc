test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export GPG_TTY="$(tty)"

export TERM="xterm-256color"
export COLORTERM="truecolor"

export PATH="$PATH:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin"

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
export MANPAGER='less'

[[ $- != *i* ]] && return
shopt -s histappend # Append to history rather than rewriting
shopt -s autocd # Allow changing to a directory without cd
shopt -s globstar # Allow using **
shopt -s extglob # Advanced globbing
shopt -s checkwinsize # Not sure what this actually does

alias ls='ls --color=auto' # Colored directory listings
alias grep='grep --color=auto' # Colored grep
alias egrep='egrep --color=auto' # Colored egrep

PROMPT_COMMAND="history -a; history -c; history -r" # Shared history
HISTSIZE=50000 # Allow in-memory history to be very big
HISTFILESIZE=50000 # Allow history file to be very big

add_to_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "/Applications/Emacs.app/Contents/MacOS/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
export HISTCONTROL="erasedups:ignoredups" # I don't think this actually works
export EDITOR='nano'

[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local" # Machine-specific settings
[[ -f "/home/deck/.nix-profile/etc/profile.d/nix.sh" ]] && . /home/deck/.nix-profile/etc/profile.d/nix.sh # Nix on steamOS
eval "$(fzf --bash)" # Fuzzy find directories and commands

if [[ "$(uname -n)" = "steamdeck" ]]; then # Weird edge case
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
fi

eval "$(starship init bash)"

# OpenClaw Completion
source "/home/benjamin/.openclaw/completions/openclaw.bash"
