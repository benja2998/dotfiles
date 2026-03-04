source ~/.bashrc
PROMPT=$'%F{blue}%B%~%b%f\n%F{green}%B❯%b%f '
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z0-9}={A-Z0-9}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
setopt CORRECT
setopt CORRECT_ALL
