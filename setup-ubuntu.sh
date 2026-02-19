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
sudo apt-get install -y stow git gh build-essential tree zoxide emacs
sudo snap install kdenlive

echo "Symlinking files"
stow .

echo "Setting up systemd service"
systemctl --user enable --now emacs

echo "Now setting up Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
