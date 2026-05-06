# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- `bash` - Bash shell configuration, aliases, history settings, PATH setup, fzf integration, and Starship initialization.
- `emacs` - Emacs configuration, local themes/modes, vterm setup, keybindings, UI preferences, and editor defaults.
- `fastfetch` - Fastfetch module list and display configuration.
- `nano` - Nano editor preferences.
- `starship` - Starship prompt configuration.
- `scripts` - Small helper scripts, including `caps.sh` for keyboard layout and Caps Lock behavior.
- `emacs-android-setup` - Helper script for installing the Emacs config in the Android Emacs port.

## Requirements

- `git`
- `stow`

Some configurations expect optional tools to be installed:

- `starship`
- `fzf`
- `fastfetch`
- `setxkbmap`
- Emacs with package access to MELPA
- JetBrains Mono Nerd Font

## Installation

Clone the repository into your home directory:

```sh
git clone git@codeberg.org:benja2998/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Install one package:

```sh
stow bash
```

Install all main packages:

```sh
stow bash emacs fastfetch nano starship scripts
```

GNU Stow creates symlinks from this repository into `$HOME`. For example, `stow bash` links `bash/.bashrc` to `~/.bashrc`.

## Local Overrides

Machine-specific Bash settings can go in:

```sh
~/.bashrc.local
```

That file is sourced by `.bashrc` when present and is intentionally kept outside this repository.

## Android Emacs

The `emacs-android-setup` script is intended to be run from `$HOME` inside the Android Emacs port. It downloads this repository and installs the Emacs configuration into `~/.emacs.d`.

Read the instructions at the top of the script before running it:

```sh
./emacs-android-setup
```

## Notes

- The `.stow-local-ignore` file prevents repository metadata and helper files from being symlinked by Stow.
- Run Stow commands from the repository root.
- Existing files in `$HOME` may need to be moved or backed up before Stow can create symlinks.
