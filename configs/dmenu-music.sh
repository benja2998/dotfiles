#!/bin/bash
shopt -s nullglob

files=(~/Music/*.{mp3,flac,opus,m4a,aac,wav,ogg,oga,alac})
[ ${#files[@]} -gt 0 ] || exit 0

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    result=$(printf '%s\n' "${files[@]}" | wmenu -i -l 10 -f "Terminess Nerd Font 16" -N "#141618" -n "#fcfcfc" -S "#ff0000" -s "#fcfcfc")
else
    result=$(printf '%s\n' "${files[@]}" | dmenu -i -l 10 -fn "Terminess Nerd Font 16" -nb "#141618" -nf "#fcfcfc" -sb "#ff0000" -sf "#fcfcfc")
fi

[ -n "$result" ] && mpv --script=/usr/lib/mpv-mpris/mpris.so "$result"
