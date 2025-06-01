#!/bin/bash

echo "Copying ./.config/fish/config.fish to ~/.config/fish/config.fish"
cp ./.config/fish/config.fish ~/.config/fish/config.fish > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Copying ./.config/neofetch/config.conf to ~/.config/neofetch/config.conf"
cp ./.config/neofetch/config.conf ~/.config/neofetch/config.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Copying ./.config/starship.toml to ~/.config/starship.toml"
cp ./.config/starship.toml ~/.config/starship.toml > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Copying ./.alias to ~/.alias"
cp ./.alias ~/.alias > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Copying ./.bashrc to ~/.bashrc"
cp ./.bashrc ~/.bashrc > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Copying ./.bash_aliases to ~/.bash_aliases"
cp ./.bash_aliases ~/.bash_aliases > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Success"
else 
    echo "Failure"
fi
echo "Setup complete"
