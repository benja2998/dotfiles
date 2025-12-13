#!/usr/bin/env bash

## Aliases

alias ls='ls --color=auto'
alias vim='nvim'
alias grep='grep --color=auto'
alias dir='dir --color=auto'

bat --version >/dev/null 2>&1

if [ $? -eq 0 ]; then
    alias cat='bat -pP'
fi

batcat --version >/dev/null 2>&1

if [ $? -eq 0 ]; then
    alias cat='batcat -pP'
fi

## Shell prompt

prompt_command() {
    local green="\[\e[32m\]"
    local blue="\[\e[34m\]"
    local red="\[\e[31m\]"
    local yellow="\[\e[33m\]"
    local reset="\[\e[0m\]"

    local user="\u"
    local host="\h"
    local pwd="\w"

    local now="$(date '+%H:%M:%S,%N')"
    local time="${now:0:8},${now:9:2}"

    local time_part="${yellow}[${time}]${reset}"

    if [[ $EUID -eq 0 ]]; then
        PS1="${time_part} ${red}${user}${reset}@${host} ${pwd} # "
    else
        PS1="${time_part} ${green}${user}@${host}${reset} ${blue}${pwd}${reset} \$ "
    fi
}

PROMPT_COMMAND=prompt_command

## Zoxide setup

zoxide --version >/dev/null 2>&1

if [ $? -eq 0 ]; then
    eval "$(zoxide init bash)"
fi
