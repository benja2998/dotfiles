if status is-interactive
    # Commands to run in interactive sessions can go here

    fortune -s | cowsay

    function run_after_command --on-event fish_postexec
        history merge
    end

    set -gx MANPATH "$HOME/.nix-profile/share/man" $MANPATH
    set -gx EDITOR 'emacsclient -c -a ""'
    set -gx GPG_TTY (tty)

    # Aliases
    alias c='cls'
    alias emacs='emacsclient -c -a ""'
    alias ytns='yt-dlp --sponsorblock-remove all'
    alias fetch='$HOME/Thirdparty/fetch/fetch'
    alias cls='clear'
    alias e='emacs -n .'
    alias ls='ls --color=auto'
    alias tree='tree -C'
    alias grep='grep --color=auto'
    alias ll='ls -larth'

    function ytsdl
	ytns --print-to-file \
	    "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" search.txt --default-search "ytsearch5:" "$argv[1]"
    end

    function kpc
	keepassxc-cli open ~/Documents/passwords.kdbx
    end

    function ytsearch
	yt-dlp --no-download \
	    --print-to-file "before_dl:%(id)s  # [Duration (H.M.S): %(duration>%H.%M.%S)s] %(title)s" \
	    search.txt --default-search "ytsearch5:" "$argv[1]" >/dev/null; cat search.txt; rm search.txt
    end

    zoxide init fish --cmd cd | source
end
