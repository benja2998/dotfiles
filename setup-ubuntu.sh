#!/bin/bash
set -e

source /etc/os-release
if [[ "$NAME" = *Ubuntu* ]]; then
    echo "Ubuntu detected, continuing"
else
    echo "Please run in Ubuntu"
    exit 1
fi

echo "Installing packages"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y stow git gh build-essential tree zoxide emacs fish
sudo snap install kdenlive

echo "Symlinking files"
stow .

echo "Setting up systemd service"
systemctl --user enable --now emacs

echo "Setting shell to fish"
chsh -s /bin/fish
