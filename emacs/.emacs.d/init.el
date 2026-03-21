;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Fix gpg
(setq epa-pinentry-mode 'loopback)

;;; Set the custom-file
(setq custom-file "~/.emacs.d/custom.el")

;;; Fix meta on macOS
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)

;;; Fix the stupid query replace keybinds
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c g") 'query-replace-regexp)

;;; Exec path from shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))

;;; Proper terminal
(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)
(global-set-key (kbd "C-x p s") #'eat-project)
(global-set-key (kbd "C-c t") #'eat)

;;; Don't show splash screen
(setq inhibit-splash-screen t)

;;; Fix indentation
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Load the custom-file
(load custom-file)

;;; Simple C mode
(add-to-list 'load-path "~/.emacs.d/local")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
