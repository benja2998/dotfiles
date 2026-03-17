[[ $- != *i* ]] && return
shopt -s histappend # Append to history rather than rewriting
shopt -s autocd # Allow changing to a directory without cd
shopt -s globstar # Allow using **
shopt -s extglob # Advanced globbing
shopt -s checkwinsize # Not sure what this actually does

alias ls='ls --color=auto' # Colored directory listings
alias grep='grep --color=auto' # Colored grep
alias egrep='egrep --color=auto' # Colored egrep
alias e='emacs .' # Open emacs in current directory

PROMPT_COMMAND="history -a; history -c; history -r" # Shared history
HISTSIZE=50000 # Allow in-memory history to be very big
HISTFILESIZE=50000 # Allow history file to be very big

export PS1="[\u@\h \W]\$ " # [user@localhost somefolder]$
export PATH="$HOME/.local/bin:/opt/local/bin:/opt/local/sbin:$PATH" # User binaries and MacPorts
export MANPATH=/opt/local/share/man:$MANPATH # Add MacPorts to manpath
export HISTCONTROL="erasedups:ignoredups" # I don't think this actually works
export EDITOR='emacsclient -c -a "" -w' # Emacs as default editor

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
