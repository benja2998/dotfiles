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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
