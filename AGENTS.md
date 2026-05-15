# AGENTS.md

Guidance for automated coding agents working in this repository.

## Repository Shape

This is a GNU Stow dotfiles repository. Top-level directories are Stow packages
that map to paths under `$HOME`.

Current packages:

- `bash`
- `emacs`
- `nano`
- `starship`
- `fastfetch`

Repository-level files such as `README.md`, `CONTRIBUTING.md`, and `AGENTS.md`
are intentionally ignored by Stow through `.stow-local-ignore`.

## Working Rules

- Keep edits scoped to the requested package or document.
- Do not rename package directories unless explicitly asked.
- Do not commit secrets, tokens, host-specific private paths, or local machine
  state.
- Do not remove user-local extension points such as `~/.bashrc.local`.
- Preserve existing style unless the task explicitly asks for a broader cleanup.
- Use 4 spaces for indentation.
- Use ASCII unless an edited file already uses non-ASCII for a clear purpose.
- Always commit completed changes before handing work back to the user.

## Validation

There is no automated test suite. Prefer targeted checks:

- `stow -n -v <package>` for a dry-run before changing symlinks.
- `stow -R <package>` when asked to apply or verify links.
- `bash -n bash/.bashrc` for Bash syntax.
- Launch or run the affected program when practical.

Do not run destructive commands such as `git reset --hard`, remove user files in
`$HOME`, or overwrite existing non-repository dotfiles unless the user explicitly
requests it.
