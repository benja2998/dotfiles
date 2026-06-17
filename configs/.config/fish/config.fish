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

	function localgpt
		llama-server -m ~/models/gpt-oss-20b-Q4_K_M.gguf -c 32768 --port 10000 -ctk q8_0 -ctv q8_0 -fa on --tools all
	end

	starship init fish | source
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
