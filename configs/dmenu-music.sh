#!/bin/bash
shopt -s nullglob

files=(~/Music/*.{mp3,flac,opus,m4a,aac,wav,ogg,oga,alac})
[ ${#files[@]} -gt 0 ] || exit 0

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    result=$(printf '%s\n' "${files[@]}" | wmenu -i -l 20 -f "Terminess Nerd Font:pixelsize=24" -N "#202326" -n "#fcfcfc" -S "#ff0000" -s "#fcfcfc")
else
    result=$(printf '%s\n' "${files[@]}" | dmenu -i -l 20 -fn "Terminess Nerd Font:pixelsize=24")
fi

[ -n "$result" ] && mpv --script=/usr/lib/mpv-mpris/mpris.so "$result"
