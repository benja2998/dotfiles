;; -*- lexical-binding: t; -*-

(editorconfig-mode t)

(setq vc-follow-symlinks t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(fido-vertical-mode t)

(setq epg-pinentry-mode 'loopback)

(savehist-mode t)

(setq inhibit-splash-screen t)
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

(add-to-list 'default-frame-alist '(font . "monospace-16"))

(setq display-line-numbers-type 'relative)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(package-initialize)

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))

(setq use-short-answers t)
(setq use-package-always-ensure t)

(use-package markdown-mode)
(use-package exec-path-from-shell)
(use-package magit)

(load-theme 'modus-vivendi :no-confirm)

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

(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook #'(lambda ()
                             (visual-line-mode t)
                             (org-indent-mode t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(exec-path-from-shell ghostel magit markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
