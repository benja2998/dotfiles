if status is-interactive
    # Commands to run in interactive sessions can go here
	if status is-login
		if test -z "$DISPLAY"; and test (tty) = /dev/tty1
			exec startx
		end
	end	
	set -gx EDITOR 'vim'
	set -gx GPG_TTY $(tty)

	function fastfetch
		command fastfetch -c examples/13
	end

	function ls
		command ls -B $argv
	end

	starship init fish | source
end

if test -d /home/linuxbrew
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
end
