if status is-interactive
    set -gx PATH $HOME/.cargo/bin $HOME/.local/bin $PATH
    set -gx EDITOR 'emacsclient -t -a ""'
    set -gx VISUAL 'emacsclient -c -a ""'

    alias emacs 'emacsclient -c -a ""'
    alias rm 'rm -i'
    alias mv 'mv -i'
    alias cp 'cp -i'

    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv | source
    else if test -x /usr/local/bin/brew
        /usr/local/bin/brew shellenv | source
    else if test -x /home/linuxbrew/.linuxbrew/bin/brew
        /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    end

    zoxide init --cmd cd fish | source
end
