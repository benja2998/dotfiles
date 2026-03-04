;;; Ensure Emacs is not too old
(let ((min-version "30.1"))
  (when (version< emacs-version min-version)
    (error "Emacs version %s or higher is required (you are running %s)" min-version emacs-version)))

;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Fix gpg
(setenv "GPG_TTY" (shell-command-to-string "tty"))
(setq epg-pinentry-mode 'loopback)

;;; Set the custom-file
(setq custom-file "~/.emacs.d/custom.el")

;;; Follow git symlinks
(setq vc-follow-symlinks t)

;;; Which-key mode (built in as of 30.1)
(which-key-mode t)

;;; Persist history
(savehist-mode t)

;;; Fix macOS modifiers
(setq ns-alternate-modifier 'meta)
(setq ns-right-alternate-modifier 'none)
(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'none)

;;; Disable UI clutter
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-splash-screen t)

;;; Don't clutter the directory with random files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;; Launch eat with a keybind
(global-set-key (kbd "C-c t") 'eat)

;;; Launch project eat with a keybind
(global-set-key (kbd "C-x p s") 'eat-project)

;;; Use eat for eshell
(add-hook 'eshell-mode-hook #'eat-eshell-mode)

;;; Font
(add-to-list 'default-frame-alist '(font . "Iosevka-20"))

;;; Theme
(load-theme 'modus-vivendi t)

;;; Visual line mode
(global-visual-line-mode t)

;;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'fundamental-mode-hook (lambda () (display-line-numbers-mode 1)))

;;; Fix indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Use short answers
(setq use-short-answers t)

;;; Load the custom-file
(load custom-file)

;;; Simple C mode
(add-to-list 'load-path "~/.emacs.d/local")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
