## Linux & macOS

Simply, use GNU Stow to symlink */. Make sure you cloned the dotfiles to a subdirectory of ~.

This is the command you should run:

```bash
stow */
```
If you hit command not found errors, install the commands.

## Windows

Set the CYGWIN environment variable to "winsymlinks:native" and enable developer mode. Then, you can just follow the instructions above.

Or even simpler, you could use WSL. It is faster than Cygwin and backed by MS.
