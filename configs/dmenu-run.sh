#!/bin/bash

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    wmenu-run -i -l 10 -f "Terminess Nerd Font 16" -N "#303446" -n "#c6d0f5" -S "#8caaee" -s "#303446"
else
    dmenu_run -i -l 10 -fn "Terminess Nerd Font 16" -nb "#303446" -nf "#c6d0f5" -sb "#8caaee" -sf "#303446"
fi
