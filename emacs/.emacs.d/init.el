;;; Load paths
(add-to-list 'custom-theme-load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/local")

;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Terminal
(global-set-key (kbd "C-c t") (lambda () (interactive) (start-process-shell-command "x-terminal-emulator" nil "x-terminal-emulator")))

;;; Font
(cond ((eq system-type 'android) (set-face-attribute 'default nil :font "Droid Sans Mono-18")) ((eq system-type 'gnu/linux) (set-face-attribute 'default nil :font "Iosevka-14")) (t (set-face-attribute 'default nil :font "Monospace-12")))

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
(global-display-line-numbers-mode)

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

;;; Gruber darker
(setq custom-safe-themes t)
(load-theme 'gruber-darker)
