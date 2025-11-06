;; Set custom file
(setq custom-file "~/.emacs.custom.el")

;; Highlight current line
(global-hl-line-mode 1)

;; Disable startup message and splash screen
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; Disable autosave and backup files
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

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
  :bind (("C-c g" . magit-status)))

;; Catppuccin theme
(use-package catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

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

;; C mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;; Powershell
(use-package powershell
  :mode (("\\.ps1\\'"  . powershell-mode)
         ("\\.psm1\\'" . powershell-mode)))

(load-file custom-file)
