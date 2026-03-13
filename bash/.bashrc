shopt -s histappend # Append to history rather than rewriting
shopt -s autocd # Allow changing to a directory without cd
shopt -s globstar # Allow using **
shopt -s extglob # Advanced globbing
shopt -s cdspell # Correct directory names when using cd
shopt -s checkwinsize # Not sure what this actually does

alias ls='ls --color=auto' # Colored directory listings
alias grep='grep --color=auto' # Colored grep
alias egrep='egrep --color=auto' # Colored egrep
alias emacs='emacsclient -c -a ""' # Emacs
alias e='emacsclient -c -a "" .' # Open emacs in current directory

PROMPT_COMMAND="history -a; history -c; history -r" # Shared history
HISTSIZE=50000 # Allow in-memory history to be very big
HISTFILESIZE=50000 # Allow history file to be very big

export PS1="[\u@\h \W]\$ " # [user@localhost somefolder]$
export PATH="/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$PATH" # MacPorts and local binaries
export HISTCONTROL="erasedups:ignoredups" # I don't think this actually works
export EDITOR='emacsclient -c -a "" -w' # Emacs as default editor

eval "$(fzf --bash)" # Fuzzy find directories and commands
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local" # Machine-specific settings
