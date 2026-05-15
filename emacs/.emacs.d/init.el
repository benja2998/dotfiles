;;; Load paths
(add-to-list 'custom-theme-load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/local")

;;; Make Emacs not put backup files in the same directory
; Source - https://stackoverflow.com/a/151946
; Posted by jfm3, modified by community. See post 'Timeline' for change history
; Retrieved 2026-04-21, License - CC BY-SA 3.0
(setq backup-directory-alist `(("." . "~/.saves")))

;;; Vterm
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package vterm
    :ensure t)

;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Terminal
(global-set-key (kbd "C-c t") #'vterm)

;;; Which-key
(which-key-mode t)

;;; Font
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font-18"))
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font-18")

;;; Fix the stupid query replace keybinds
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c g") 'query-replace-regexp)

;;; Exec path from shell
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;; Don't show splash screen
(setq inhibit-splash-screen t)

;;; Fix indentation
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4)

(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'fundamental-mode-hook #'display-line-numbers-mode)

;;; Clean up UI
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;;; Pixel scrolling
(pixel-scroll-precision-mode t)

;;; Follow vc symlinks
(setq vc-follow-symlinks t)

;;; Ido mode
(ido-mode t)
(ido-everywhere t)

;;; Simple C mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; Theme
(load-theme 'gruber-darker t)

;;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
