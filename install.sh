#!/usr/bin/env bash

set -ex

source /etc/os-release

if [ "$NAME" != "Ubuntu" ]; then
    echo "Unsupported operating system"
    exit 1
fi

sudo apt install emacs stow ripgrep git build-essential cmake
brew install fzf fastfetch vim
sudo snap install spotify obsidian mission-center
flatpak install com.github.tchx84.Flatseal com.obsproject.Studio io.lmms.LMMS org.audacityteam.Audacity org.keepassxc.KeePassXC org.prismlauncher.PrismLauncher org.vinegarhq.Sober
stow */
