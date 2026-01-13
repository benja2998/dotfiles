## Notes

These dotfiles are really just for me, I don't recommend you use them. The installation section is more of a note to myself.

## Installation

### macOS

These are the commands you should run:

```bash
stow .
```

If you hit command not found errors, install the commands.

### Linux

Assuming you use Ubuntu,run `setup-ubuntu.sh`. It will install everything needed, set up Linuxbrew, change the default shell, and run the stow command.

### Windows

Set the CYGWIN environment variable to "winsymlinks:native" and enable developer mode. Then, you can just follow the instructions above.

Or even simpler, you could use WSL. It is faster than Cygwin and backed by MS.
