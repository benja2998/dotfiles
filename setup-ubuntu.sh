#!/bin/bash
set -e

source /etc/os-release
if [[ "$NAME" = *Ubuntu* ]]; then
    echo "Ubuntu detected, continuing"
else
    echo "Please run in Ubuntu"
    exit 1
fi

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y kitty emacs nano tmux stow git gh build-essential tree fzf zoxide
sudo snap install kdenlive

gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

echo "Choose kitty as default terminal"
sudo update-alternatives --config x-terminal-emulator

stow .

echo "Now setting up Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
