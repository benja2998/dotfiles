;; -*- lexical-binding: t; -*-

(require 'eshell)

(add-to-list 'load-path (concat user-emacs-directory "local/"))

(require 'neofetch)

(editorconfig-mode t)

(require 'eglot)
(add-hook 'prog-mode-hook #'eglot-ensure)

(global-set-key (kbd "M-h") #'windmove-left)
(global-set-key (kbd "M-j") #'windmove-down)
(global-set-key (kbd "M-k") #'windmove-up)
(global-set-key (kbd "M-l") #'windmove-right)

(global-set-key (kbd "C-c s") #'eglot-code-actions)
(global-set-key (kbd "C-c C-r") #'eglot-rename)

(defun dired-notes ()
  (interactive)
  (dired "~/Documents/Notes")
  )

(defun dired-home ()
  (interactive)
  (dired "~")
  )

(global-set-key (kbd "C-c nh") #'dired-home)
(global-set-key (kbd "C-c nd") #'dired-notes)

(which-key-mode t)

(setq vc-follow-symlinks t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

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

;; Source - https://stackoverflow.com/a/22176971
;; Posted by user2053036, modified by community. See post 'Timeline' for change history
;; Retrieved 2026-06-20, License - CC BY-SA 3.0

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(add-to-list 'default-frame-alist '(font . "Terminess Nerd Font-16"))

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
(use-package doom-modeline)
(use-package org-superstar)
;; Enable Vertico.
(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
(use-package company)
(require 'company)
(global-company-mode t)
(use-package solarized-theme)
(load-theme 'solarized-dark :no-confirm)
(use-package colorful-mode
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))
(use-package eshell-prompt-extras)
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))
(require 'doom-modeline)
(doom-modeline-mode 1)

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(global-set-key (kbd "C-c e") #'eshell)

(add-hook 'eshell-mode-hook #'(lambda ()
								(add-to-list 'eshell-visual-commands "tinydash")))

(setq eshell-destroy-buffer-when-process-dies t)
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook #'(lambda ()
                             (visual-line-mode t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5f5770ecd10cb9a93f2df4bd05a5d6102892941cf2795eaffa4ed24d78e5a6f6"
	 "5e1741398293d0df87244a34ad47241e10f57b06e07cd62ad44089ab95d85e01"
	 "f44bb32804c6dc06f539c82ff978f7178eef577caa90c0b89260fa4e67ba3322"
	 "97883740d8f11ce7c1470ed8270afc15f45e6dac244af9b6ffd19c930ea7b224"
	 "3601d00861446211cfd3831d2ccef176ceb7de11d24e6ee1d725ec6b7000d51a"
	 "90c390c234a3c5d92ac5e3589893e03e963a11a16db448b1bae243e988efadec"
	 "4db745f7ba0382641879fa0d22bf7fd0d508e3097325e588aeaa999930a69c96"
	 "4106992a80cd7577fe00e245efb8bb1b1634eebc83ac6eb433aad94d4fe3b277"
	 "190cc1fa948c584b5249c4cb9d291741b411725a9de4217e35dceacfb01b83af"
	 "ec62fb807e829715a4d1f5f203caf0269c70636503a56090ab1c0ea6ba6e3d93"
	 "65577618e9064f96f8e693a1b3186b9501beead85de864cf700eb2b49ed337c7"
	 "bf0553e3a3b19f00fb188d1f43fc9f36b1d841338bfa5d43b31fdb02061ecff0"
	 "2780e94926161e072b6e4e45ee0ea9619076d8c05c581dce52ac32d5b1db1fea"
	 "2a564a42029d98a8d2ceaeea6df5621db48085c474bc03761f4c258ae34af06c"
	 "e1937c2748656b49cb6636a0c1a999f58e4acde3d24fa583ee7ecc38fc656c6c"
	 "eb404ef3a5ec124e7312dc37476c49b2e588d3b060b67ba222e51e6662f648cf"
	 "ffa253294a6a68181986e9b4110d7176deaf007198b6677d5a9fecb2401ac951"
	 "820f02e02cddf808f79de2749bff5c3c570529249ebb76767988a1ca7d923cd7"
	 "5b598ea012ecbc5641643c8bda01ca4e3662582a432a66a27822b78f402945ca"
	 default))
 '(evil-undo-system 'undo-redo)
 '(package-selected-packages
   '(catppuccin-theme colorful-mode company doom-modeline
					  eshell-prompt-extras exec-path-from-shell magit
					  marginalia markdown-mode orderless org-superstar
					  solarized-theme vertico))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
