export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias tree='tree -C'
alias grep='grep --color=auto'
alias vim='ivim || nvim || vim'
if [ -x "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
	eval "$(/usr/local/bin/brew shellenv)"
elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
eval "$(starship init bash)" || true && PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
