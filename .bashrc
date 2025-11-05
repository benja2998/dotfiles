#!/usr/bin/env bash

## Aliases

alias ls='ls --color=auto'
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
    local exit_code=$?
    local green="\[\e[32m\]"
    local blue="\[\e[34m\]"
    local red="\[\e[31m\]"
    local yellow="\[\e[33m\]"
    local reset="\[\e[0m\]"

    local user="\u"
    local host="\h"
    local pwd="\w"

    # Exit code color
    if [[ $exit_code -eq 0 ]]; then
        exit_part="${yellow}[${exit_code}]${reset}"
    else
        exit_part="${red}[${exit_code}]${reset}"
    fi

    # Detect root
    if [[ $EUID -eq 0 ]]; then
        PS1="${exit_part} ${red}${user}${reset}@${host} ${pwd} # "
    else
        PS1="${exit_part} ${green}${user}@${host}${reset} ${blue}${pwd}${reset} \$ "
    fi
}

PROMPT_COMMAND=prompt_command
