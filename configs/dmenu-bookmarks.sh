#!/bin/bash

menu_items=$(printf 'whatsapp\nwhiteboard\nsyncthing\nreddit\nyoutube\ngithub\ncodeberg\nmeet\nprotonmail\ngmail\ntwitch\npolytoria\n')

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    result=$(printf '%s' "$menu_items" | wmenu -i -l 10 -f "Terminess Nerd Font 16" -N "#141618" -n "#fcfcfc" -S "#ff0000" -s "#fcfcfc")
else
    result=$(printf '%s' "$menu_items" | dmenu -i -l 10 -fn "Terminess Nerd Font 16" -nb "#141618" -nf "#fcfcfc" -sb "#ff0000" -sf "#fcfcfc")
fi

case $result in
    whatsapp)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://web.whatsapp.com
        ;;
    whiteboard)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://whiteboard.cloud.microsoft
        ;;
    syncthing)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community http://127.0.0.1:8384/
        ;;
    reddit)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://reddit.com
        ;;
    youtube)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://youtube.com/feed/subscriptions
        ;;
    github)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://github.com
        ;;
    codeberg)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://codeberg.org
        ;;
    meet)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://meet.google.com
        ;;
    protonmail)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://mail.proton.me
        ;;
    gmail)
        xdotool key super+1	
        flatpak run io.gitlab.librewolf-community https://gmail.com
        ;;
    twitch)
	xdotool key super+1	
	flatpak run io.gitlab.librewolf-community https://twitch.tv
	;;
    polytoria)
	xdotool key super+1	
	flatpak run io.gitlab.librewolf-community https://polytoria.com
	;;    
    *)
	if ! [ "$result" = "" ]; then
	    xdotool key super+1	    
	    flatpak run io.gitlab.librewolf-community http://localhost:8080/search?q="$result"
	fi
        ;;
esac
