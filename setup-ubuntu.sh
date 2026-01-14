#!/bin/bash
set -e

source /etc/os-release # Fuck modern security practices, YOLO! Who cares if this file has arbitrary code?
if [[ "$NAME" = *Ubuntu* ]]; then
	echo "Ubuntu detected, continuing"
else
	echo "Please run in Ubuntu"
	exit 1
fi

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y vim tmux stow git gh build-essential tree
sudo apt-get remove -y nano

echo "Choose Gnome Terminal as default terminal"
sudo update-alternatives --config x-terminal-emulator

stow .

echo "Now setting up Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Absolutely secure!
echo "Changing default shell to bash"
chsh -s /bin/bash
