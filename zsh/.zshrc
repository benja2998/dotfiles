#!/usr/bin/env zsh

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
    local green="%F{green}"
    local blue="%F{blue}"
    local red="%F{red}"
    local yellow="%F{yellow}"
    local reset="%f"

    local user="%n"
    local host="%m"
    local pwd="%~"

    local now="$(date '+%H:%M:%S,%N')"
    local time="${now:0:8},${now:9:2}"

    local time_part="${yellow}[${time}]${reset}"

    if [[ $EUID -eq 0 ]]; then
        PS1="${time_part} ${red}${user}${reset}@${host} ${pwd} # "
    else
        PS1="${time_part} ${green}${user}@${host}${reset} ${blue}${pwd}${reset} \$ "
    fi
}

precmd() {
    prompt_command
}

## Zoxide setup

zoxide --version >/dev/null 2>&1
if [ $? -eq 0 ]; then
    eval "$(zoxide init zsh)"
fi
