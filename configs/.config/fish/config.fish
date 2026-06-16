if status is-interactive
    # Commands to run in interactive sessions can go here
	if status is-login
		if test -z "$DISPLAY"; and test (tty) = /dev/tty1
			exec startx
		end
	end	
	set -gx EDITOR 'emacsclient -c -a ""'
	set -gx GPG_TTY $(tty)
	function emacs
		emacsclient -c -a "" $argv		 
	end	

	starship init fish | source
end
