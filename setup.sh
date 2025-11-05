#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Neovim config directory
NVIM_CONFIG="$HOME/.config/nvim"

# Create config directory if it doesn't exist
if [ ! -d "$NVIM_CONFIG" ]; then
    echo "Creating Neovim config directory..."
    mkdir -p "$NVIM_CONFIG"
fi

# Create symlink for init.lua
ln -sf "$DOTFILES_DIR/neovim/init.lua" "$NVIM_CONFIG/init.lua"
echo "Symlink for init.lua created."

echo "Neovim setup complete."
# Create symlink for .emacs
ln -sf "$DOTFILES_DIR/emacs/.emacs" "$HOME/.emacs"
echo "Symlink for .emacs created."

ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
