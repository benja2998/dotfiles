#!/bin/bash

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    wmenu-run -i -l 10 -f "Terminess Nerd Font:size=16" -N "#202326" -n "#fcfcfc" -S "#ff0000" -s "#202326"
else
    dmenu_run -i -l 10 -fn "Terminess Nerd Font:size=16" -nb "#202326" -nf "#fcfcfc" -sb "#ff0000" -sf "#202326"
fi
