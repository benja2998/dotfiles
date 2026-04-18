;;; Load paths
(add-to-list 'custom-theme-load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/local")

;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Fix gpg
(setq epa-pinentry-mode 'loopback)

;;; Eat terminal
(add-hook 'eshell-load-hook #'eat-eshell-mode)
(global-set-key (kbd "C-c t") #'eat)
(global-set-key (kbd "C-x p s") #'eat-project)

;;; Set the custom-file
(setq custom-file "~/.emacs.d/custom.el")

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
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Load the custom-file
(load custom-file)

;;; Ido mode
(ido-mode 1)
(ido-everywhere 1)

;;; Simple C mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; Gruber darker
(load-theme 'gruber-darker)
