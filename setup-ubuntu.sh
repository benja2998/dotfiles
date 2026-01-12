#!/bin/bash
set -e

source /etc/os-release # Fuck modern security practices, YOLO
if [[ "$NAME" = *Ubuntu* ]]; then
	echo "Ubuntu detected, continuing"
else
	echo "Please run in Ubuntu"
fi

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y vim tmux zsh alacritty stow git gh build-essential make tree
ALACRITTY_BIN=$(which alacritty)

if [ -z "$ALACRITTY_BIN" ]; then
    exit 1
fi

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$ALACRITTY_BIN" 70

echo "Choose Alacritty as default terminal"
sudo update-alternatives --config x-terminal-emulator

gsettings set org.gnome.desktop.default-applications.terminal exec "$ALACRITTY_BIN"
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ""

stow .

echo "Now setting up Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Absolutely secure!
echo "Changing default shell"
chsh -s /bin/zsh
