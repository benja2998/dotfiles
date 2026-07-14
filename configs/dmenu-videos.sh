#!/bin/bash
shopt -s nullglob

files=(~/Videos/*.{webm,mp4,mkv,mov,avi,flv,m4v,wmv,ogv,ts})
[ ${#files[@]} -gt 0 ] || exit 0

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    result=$(printf '%s\n' "${files[@]}" | wmenu -i -l 10 -f "Terminess Nerd Font 16" -N "#1e1e2e" -n "#cdd6f4" -S "#89b4fa" -s "#1e1e2e")
else
    result=$(printf '%s\n' "${files[@]}" | dmenu -i -l 10 -fn "Terminess Nerd Font 16" -nb "#1e1e2e" -nf "#cdd6f4" -sb "#89b4fa" -sf "#1e1e2e")
fi

[ -n "$result" ] && xdotool key super+6 && mpv --script=/usr/lib/mpv-mpris/mpris.so "$result"
