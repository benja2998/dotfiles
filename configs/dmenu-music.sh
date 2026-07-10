#!/bin/bash
files=(~/Music/*.opus)
[ -e "${files[0]}" ] || exit 0

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
	result=$(printf '%s\n' "${files[@]}" | wmenu -l 10 -f "Terminess Nerd Font 16" -N "#303446" -n "#c6d0f5" -S "#8caaee" -s "#303446")
else
	result=$(printf '%s\n' "${files[@]}" | dmenu -l 10 -fn "Terminess Nerd Font 16" -nb "#303446" -nf "#c6d0f5" -sb "#8caaee" -sf "#303446")
fi

[ -n "$result" ] && mpv --script=/usr/lib/mpv-mpris/mpris.so "$result"
