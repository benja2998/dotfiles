;; -*- lexical-binding: t; -*-

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
(use-package nerd-icons)
(use-package doom-modeline :init (doom-modeline-mode 1))
(use-package magit :defer t)
(use-package catppuccin-theme)

(setq catppuccin-flavor 'frappe)
(load-theme 'catppuccin :no-confirm)

(use-package ghostel
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
         :map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
  :config
  (defun my/ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel.
Like normal Emacs `C-k'.  Kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

  (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
  (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t)
  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer)))

(global-company-mode t)

(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook #'(lambda ()
                             (visual-line-mode t)
                             (org-indent-mode t)))

(with-eval-after-load 'dired
  (require 'dired-x))

(which-key-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a"
	 "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
	 "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
	 "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
	 default))
 '(erc-modules
   '(autojoin button completion fill imenu irccontrols list match menu
			  move-to-prompt netsplit networks readonly ring stamp
			  track))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((tokyonight-themes :url
						"https://github.com/xuchengpeng/tokyonight-themes"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
