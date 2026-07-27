#!/bin/bash

set -euo pipefail

NAME="tty-screenshot.png"
TTY="1"

while getopts "t:n:" opt; do
    case $opt in
	n)
	    NAME="$OPTARG"
	    ;;
	t)
	    TTY="$OPTARG"
	    ;;
	*)
	    echo "Usage: $0 -t <tty number> -n <filename.png>"
	    exit 64
	    ;;
    esac
done

if [[ -z "$NAME" ]] || [[ -z "$TTY" ]]; then
    echo "No name or tty provided"
    exit 64
fi

sudo fbgrab -c $TTY "$NAME"
