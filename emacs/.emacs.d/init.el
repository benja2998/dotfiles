;;; Set the custom-file
(setq custom-file "~/.emacs.d/custom.el")

;;; Follow git symlinks
(setq vc-follow-symlinks t)

;;; Persist history
(savehist-mode t)

;;; Disable UI clutter
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-splash-screen t)

;;; Don't clutter the directory with random files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;; Launch ansi-term with a keybind
(global-set-key (kbd "C-c t") 'ansi-term)

;;; Font
(cond ((eq system-type 'android) (set-face-attribute 'default nil :font "Droid Sans Mono-16")) ((eq system-type 'gnu/linux) (set-face-attribute 'default nil :font "Iosevka-20")) ((eq system-type 'darwin) (set-face-attribute 'default nil :font "Iosevka-20")) (t (set-face-attribute 'default nil :font "Monospace-12")))

;;; Catppuccin theme
(setq catppuccin-flavor 'macchiato)
(load-theme 'catppuccin :no-confirm)

;;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

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
