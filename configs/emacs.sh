#!/bin/bash
pkill -u "${USER}" -x -f "emacs --daemon" >/dev/null 2>&1
emacs --daemon
