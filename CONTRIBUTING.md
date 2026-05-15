# Contributing

This is a personal dotfiles repository. Changes should stay small, explicit, and
easy to audit.

## Workflow

1. Make edits in the relevant Stow package directory.
2. Restow the package to verify links:

   ```sh
   stow -R <package>
   ```

3. Open a new shell or application session and confirm the changed config loads.
4. Check the worktree before committing:

   ```sh
   git status --short
   ```

## Guidelines

- Keep package boundaries clear. For example, Bash config belongs in `bash/` and
  Starship config belongs in `starship/`.
- Do not commit machine-local secrets, tokens, host-specific paths, or private
  configuration. Prefer local include files such as `~/.bashrc.local`.
- Avoid unrelated formatting churn. Dotfiles are easier to review when changes
  are narrow.
- Use 4 spaces for indentation.
- Prefer comments only when they explain a non-obvious choice.
- Keep generated editor state, swap files, package caches, and local backups out
  of the repository.

## Validation

There is no automated test suite. Validate changes by loading the affected tool:

- Bash: start a new interactive shell.
- Emacs: launch Emacs and check `*Messages*` for startup errors.
- Nano: start Nano and confirm options behave as expected.
- Starship: run `starship explain` or start a new shell.
- Fastfetch: run `fastfetch`.

If a change depends on an external program, note that dependency in `README.md`.
