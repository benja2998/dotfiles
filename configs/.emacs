;; -*- lexical-binding: t; -*-

(setq custom-file (make-temp-file "emacs-custom"))

(fido-mode t)
(fido-vertical-mode t)
(savehist-mode t)

(add-hook 'prog-mode-hook #'eglot-ensure)

(setq vc-follow-symlinks t)

(setq-default scroll-conservatively 101)

(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq-default indent-tabs-mode t)

(setq-default c-default-style "linux")
(setq-default c-ts-mode-indent-style 'linux)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'c-ts-indent-offset 'tab-width)

; Source - https://stackoverflow.com/a/22176971
; Posted by user2053036, modified by community. See post 'Timeline' for change history
; Retrieved 2026-06-20, License - CC BY-SA 3.0

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

; Source - https://stackoverflow.com/a/22176971
; Posted by user2053036, modified by community. See post 'Timeline' for change history
; Retrieved 2026-06-20, License - CC BY-SA 3.0

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(setq epg-pinentry-mode 'loopback)

(cond ((eq system-type 'gnu/linux)
	   (add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-16")))
	  (t
	   (add-to-list 'default-frame-alist '(font . "monospace-24"))))

(scroll-bar-mode -1)

(global-auto-revert-mode t)

(setq display-line-numbers-type 'relative)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(package-initialize)

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))

(setq use-short-answers t)
(setq use-package-always-ensure t)

(use-package systemd)
(use-package markdown-mode)
(use-package exec-path-from-shell)
(use-package fish-mode)
(use-package company)
(use-package spaceline)
(use-package vterm :defer t)
(use-package magit :defer t)

(global-company-mode t)

(setq treesit-auto-install-grammar 'always)
(setq-default treesit-auto-install-grammar 'always)
(add-to-list 'major-mode-remap-alist
			 '(c-mode . c-ts-mode) t)
(add-to-list 'major-mode-remap-alist
			 '(c++-mode . c++-ts-mode) t)
(add-to-list 'major-mode-remap-alist
			 '(sh-mode . bash-ts-mode) t)
(add-to-list 'major-mode-remap-alist
			 '(shell-script-mode . bash-ts-mode) t)
(add-to-list 'major-mode-remap-alist
			 '(lua-mode . lua-ts-mode) t)
(add-to-list 'major-mode-remap-alist
			 '(javascript-mode . js-ts-mode) t)
(add-to-list 'auto-mode-alist
			 '("\\.luau\\'" . lua-ts-mode) t)
(add-to-list 'auto-mode-alist
			 '("\\.zsh\\'" . bash-ts-mode) t)
(setq treesit-enabled-modes t)
(setq-default treesit-enabled-modes t)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(load-theme 'modus-vivendi :no-confirm)

(add-hook 'org-mode-hook #'(lambda ()
                             (visual-line-mode t)
                             (org-indent-mode t)))

(global-set-key (kbd "C-c t") 'vterm)
(with-eval-after-load 'dired
  (require 'dired-x))

(which-key-mode t)
