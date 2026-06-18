if status is-interactive
    # Commands to run in interactive sessions can go here
	if status is-login
		if test -z "$DISPLAY"; and test (tty) = /dev/tty1
			exec startx
		end
	end	
	set -gx EDITOR 'emacsclient -c'

	function fastfetch
		command fastfetch -c examples/13
	end

	function ls
		command ls -B $argv
	end

	function emacs
		emacsclient -c $argv
	end

	starship init fish | source
end

if test -d /home/linuxbrew
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
end
