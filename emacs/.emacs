;; Set custom file
(setq custom-file "~/.emacs.custom.el")

;; Disable startup message and splash screen
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; Remove swpa files
(setq auto-save-default nil)

;; Remove menu bar
(menu-bar-mode -1)

;; Show line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Set windmove keybinds
(windmove-default-keybindings)

(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

(require 'package)

;; Add MELPA
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Initialize package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Install Magit
(use-package magit
  :bind (("C-x g" . magit-status)))

;; Install a theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

;; Disable tool bar and scroll bar
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Always use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set tab width to 4 spaces
(setq-default tab-width 4)

;; Autocomplete
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-selection-wrap-around t))

(use-package eglot)

;; Set font size
(set-face-attribute 'default nil :font "Monospace-14")

;; Ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere t)


