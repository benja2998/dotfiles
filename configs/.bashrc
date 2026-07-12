[[ $- != *i* ]] && return

export LC_ALL=C.UTF-8

export EDITOR='emacsclient -c -a ""'
alias code='code-oss'
export GPG_TTY=$(tty)
alias ls="ls -B --color=auto"
alias emacs='emacsclient -c -a ""'
alias tree="tree -C"
alias grep="grep --color=auto"
alias ll="ls -larth"

if [ "$TERM" = "xterm-ghostty" ]; then
	export TERM=xterm-256color
fi

HISTSIZE=-1
HISTFILESIZE=-1

export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

shopt -s globstar
shopt -s extglob
shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

cdf() {
	cd "$(find -type d | fzf)" || true
}

ytsearch() {
	rm search.txt
	yt-dlp --no-download --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
	cat search.txt
}

ytsdl() {
	rm search.txt
	yt-dlp --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$1" >/dev/null
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
	if tmux has-session -t $SESN 2>/dev/null; then
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

			if [ "$SESN" = "Notes" ]; then
				tmux send-keys -t 0 "vim .; exit" C-m
			fi

			tmux attach-session -t $SESN
		fi
	fi
}

[[ $- == *i* ]] && return
