if status is-interactive
    # Commands to run in interactive sessions can go here
	set -gx EDITOR 'emacsclient -c -a ""'
	set -gx GPG_TTY $(tty)
	function emacs
	emacsclient -c -a "" $argv		 
	end

	starship init fish | source
end
