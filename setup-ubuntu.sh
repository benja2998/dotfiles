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
sudo apt-get install -y emacs nano tmux stow git gh build-essential tree fzf

gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

echo "Choose Alacritty as default terminal"
sudo update-alternatives --config x-terminal-emulator

stow .

echo "Now setting up Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Changing default shell to bash"
chsh -s /bin/bash
echo "Installing starship"
curl -sS https://starship.rs/install.sh | sh
