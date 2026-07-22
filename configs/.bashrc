[[ $- != *i* ]] && return

export LC_ALL=C.UTF-8

export EDITOR='vis'
alias code='code-oss'
alias cls='clear'
alias gls='git log --reverse --show-signature'
alias gl='git log --reverse'
alias ytns='yt-dlp --sponsorblock-remove all'
alias fetch='$HOME/Thirdparty/fetch/fetch'
alias gs='git status'
alias gsh='git show'
alias ga='git add -A'
alias gp='git push'
alias gc='git commit -m'
alias gd='git diff'
alias gf='git fetch'
alias gpl='git pull --rebase'
alias gpt='git push --tags'
export GPG_TTY=$(tty)
alias ls="ls --color=auto"
alias emacs='emacsclient -c -a ""'
alias tree="tree -C"
alias grep="grep --color=auto"
alias ll="ls -larth"
bind -f ~/.inputrc
bind -x '"\C-f":tmux-session'
bind -x '"\C-e":ff'
bind -x '"\C-n":tmux-notes'

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s globstar
shopt -s extglob
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

PS1='[\u@\h \W]\$ '

cdf() {
	cd "$(find -type d | fzf)" || true
}

ff() {
	file="$(find -type f -not -path './.git/*' | fzf)"
	if [ -z "$file" ]; then
		return
	fi
	vis "$file"
}

ytsearch() {
	rm search.txt
	yt-dlp --no-download --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
	cat search.txt
}

ytsdl() {
	rm search.txt
	ytns --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
	cat search.txt
}

tmux-session() {
	local SESS="$(find -type d | fzf)"
	if [ -z "$SESS" ]; then
		echo No directory
		return
	fi
	local EXST=0
	local SESN="$(basename $SESS)"
	if tmux has-session -t "=$SESN" 2>/dev/null; then
		EXST=1
	else
		EXST=0
	fi

	# Now actually do the stuff
	if [ -z "$TMUX" ]; then
		if [ "$EXST" = 1 ]; then
			tmux attach-session -t $SESN
		else
			tmux new-session -d -s $SESN
			tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

			tmux attach-session -t $SESN
		fi
	fi
}

tmux-notes() {
	local SESS="$HOME/Documents/Notes"
	local EXST=0
	local SESN="$(basename $SESS)"
	if tmux has-session -t "=$SESN" 2>/dev/null; then
		EXST=1
	else
		EXST=0
	fi

	# Now actually do the stuff
	if [ -z "$TMUX" ]; then
		if [ "$EXST" = 1 ]; then
			tmux attach-session -t $SESN
		else
			tmux new-session -d -s $SESN
			tmux send-keys -t 0 "cd \"$SESS\"" C-m "clear" C-m

			tmux attach-session -t $SESN
		fi
	fi
}

[[ $- == *i* ]] && return
