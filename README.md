# Dotfiles
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbenja2998%2Fdotfiles.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbenja2998%2Fdotfiles?ref=badge_shield)


Configuration files for **benja2998**.

## Overview

This repository provides configuration for multiple programs.

### Shells

* Cmd
* PowerShell
* Bash

### Terminal Emulators

* Windows Console

### Text Editors

* Neovim
* Emacs

## Why Use These

This repository provides a consistent configuration across these three shells. Each has the same prompt and similar aliases.

## Unique Features

* This repository has [configuration for the Windows Console](conhost/console.reg)
* This repository implements [Zoxide for Cmd](cmd/scripts/z.bat)

## Installation

### MS-Windows

```batch
gh repo clone benja2998/dotfiles
cd dotfiles
.\setup.bat
```

### POSIX

```bash
gh repo clone benja2998/dotfiles
cd dotfiles
dos2unix setup.sh
chmod +x setup.sh
./setup.sh
```

## Notes

The configuration files for POSIX systems require:

* bat
* zoxide

These are not installed automatically by `setup.sh`, they are only installed automatically by `setup.bat`.


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbenja2998%2Fdotfiles.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbenja2998%2Fdotfiles?ref=badge_large)