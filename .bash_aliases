## FUNCTIONS ##

git_branch() {
	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [ -n "$branch" ]; then
		echo -n "$branch "
	fi
}

check_on_branch() {
	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [ -n "$branch" ]; then
		echo -n "on "
	fi
}

## SHELL PROMPT ##

#PS1='\[\e[1;31m\]\u@\h\[\e[0m\] in \[\e[1;34m\]\w\[\e[0m\] $(check_on_branch)\[\e[1;32m\]$(git_branch)\[\e[0m\]\[\e[1;37m\]>_\[\e[0m\] '

## ALIASES ##

alias vim='nvim'
alias ls='ls --color=auto -lh'
alias la='ls --color=auto -lah'
alias dir='dir'
alias l='ls'
alias clr='clear'
alias sudo='doas'
alias apt='nala'
alias :q='exit 1'
alias :wq='exit 0'

## STARTUP ##

eval "$(starship init bash)"
clear
