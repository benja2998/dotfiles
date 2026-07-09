#!/bin/bash
files=(~/Music/*)
[ -e "${files[0]}" ] || exit 0

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
	result=$(printf '%s\n' "${files[@]}" | wmenu -l 10 -f "Terminess Nerd Font 16" -N "#24273a" -n "#cad3f5" -S "#8aadf4" -s "#24273a")
else
	result=$(printf '%s\n' "${files[@]}" | dmenu -l 10 -fn "Terminess Nerd Font 16" -nb "#24273a" -nf "#cad3f5" -sb "#8aadf4" -sf "#24273a")
fi

[ -n "$result" ] && mpv --script=/usr/lib/mpv-mpris/mpris.so "$result"
