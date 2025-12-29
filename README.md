dotfiles
========

Simply, use GNU Stow to symlink */. Make sure you cloned the dotfiles to a subdirectory of ~.

This is the command you should run:

```bash
stow */
```

If you hit command not found errors, install the commands. Here are most of the commands you'll need:

fzf xclip rofi feh dunst bash zsh tmux fzf picom

If you're going to use i3, install the i3ipc Python package.

There should be a script called clone-tmux-catppuccin.sh in your home directory after you run Stow. Please run that script.
