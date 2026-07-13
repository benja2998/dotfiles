#!/bin/bash

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    result=$(printf 'whatsapp\nwhiteboard\nsyncthing\nreddit\n' | wmenu -l 10 -f "Terminess Nerd Font 16" -N "#303446" -n "#c6d0f5" -S "#8caaee" -s "#303446")
else
    result=$(printf 'whatsapp\nwhiteboard\nsyncthing\nreddit\n' | dmenu -l 10 -fn "Terminess Nerd Font 16" -nb "#303446" -nf "#c6d0f5" -sb "#8caaee" -sf "#303446")
fi

case $result in
    whatsapp)
	firefox https://web.whatsapp.com
	xdotool key super+1
	;;
    whiteboard)
	firefox https://whiteboard.cloud.microsoft
	xdotool key super+1
	;;
    syncthing)
	firefox http://127.0.0.1:8384/
	xdotool key super+1
	;;
    reddit)
	firefox https://reddit.com
	xdotool key super+1
	;;
    *)
	;;
esac
