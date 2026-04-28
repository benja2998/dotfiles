#!/bin/sh
setxkbmap -option ctrl:nocaps
setxkbmap latam
setxkbmap -option ctrl:nocaps
while true; do
    VOL=$(amixer get Master | awk -F'[][]' 'END{ print $2 }')

    TIME=$(date '+%Y-%m-%d %H:%M')

    xsetroot -name "VOL: $VOL | $TIME"

    sleep 0.1
done
