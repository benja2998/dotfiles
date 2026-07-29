# .bash_profile
export PATH="/var/lib/flatpak/exports/bin:$HOME/.local/bin:$PATH"

if [ "$(tty)" = "/dev/tty1" ] && [ -z "$DISPLAY" ]; then
    docker restart searxng-core & disown    
    exec startx
fi

# if [ "$(tty)" = "/dev/tty2" ]; then
#     syncthing serve --no-browser --logfile=default & disown
# fi

# if [ "$(tty)" = "/dev/tty3" ]; then
#     pipewire
# fi

# if [ "$(tty)" = "/dev/tty4" ]; then
#     wiremix
# fi

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
