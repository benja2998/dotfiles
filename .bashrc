export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PS1='\W \$ '
export EDITOR="kate"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias tree='tree -C'
alias grep='grep --color=auto'
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
eval "$(zoxide init --cmd cd bash)"
