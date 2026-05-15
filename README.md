# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a Stow package. Installing a package creates symlinks
from that package into `$HOME` while keeping the source files in this repository.

## Packages

- `bash`: Bash startup configuration, history behavior, aliases, paths, `fzf`,
  and Starship initialization.
- `emacs`: Emacs configuration under `.emacs.d`, including package setup,
  keybindings, UI preferences, and editor defaults.
- `nano`: Nano editor preferences.
- `starship`: Starship prompt configuration.
- `fastfetch`: Fastfetch display configuration.

## Requirements

- `git`
- `stow`
- Bash for the shell configuration
- Optional tools used by the configs:
  - `emacs`
  - `fzf`
  - `starship`
  - `fastfetch`
  - `JetBrainsMonoNL Nerd Font`

## Install

Clone the repository into `$HOME/.dotfiles`:

```sh
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
```

Install one package:

```sh
stow bash
```

Install all current packages:

```sh
stow bash emacs nano starship fastfetch
```

If a target file already exists in `$HOME`, Stow will report a conflict. Move the
existing file aside, compare it with the version in this repo, then rerun `stow`.

## Update

Edit files in this repository, then restow the relevant package:

```sh
stow -R bash
```

Machine-specific Bash settings should go in `~/.bashrc.local`; that file is
sourced by `bash/.bashrc` and should not be committed here.

## Repository Notes

`.stow-local-ignore` excludes repository metadata and documentation files from
Stow operations, so files like this README stay in the repo root instead of being
linked into `$HOME`.
