;; -*- lexical-binding: t; -*-

(require 'eshell)

(add-to-list 'load-path (concat user-emacs-directory "local/"))

(defun daily-note ()
  (interactive)
  (setq current-date-file (concat "~/Documents/Notes/" (format-time-string "%Y" (current-time)) "/" (format-time-string "%d-%m-%Y" (current-time)) ".org"))
  (setq current-date (format-time-string "%d-%m-%Y" (current-time)))
  (find-file current-date-file)
  (unless (file-exists-p current-date-file)
    (insert (concat "* " current-date (format "\n"))))
  )

(defun todo-note ()
  (interactive)
  (find-file "~/Documents/Notes/todo.org")
  )

(pixel-scroll-precision-mode t)

(require 'bind-key)
(bind-key* "C-c nt" 'daily-note)
(bind-key* "M-h" 'windmove-left)
(bind-key* "M-j" 'windmove-down)
(bind-key* "M-k" 'windmove-up)
(bind-key* "M-l" 'windmove-right)
(bind-key* "C-c tn" 'todo-note)
(bind-key* "C-c ne" 'org-agenda-list)
(bind-key* "C-c re" 'eglot-format-buffer)

(setq eshell-history-size 10000)

(require 'neofetch)

(editorconfig-mode t)

(require 'eglot)
(add-hook 'prog-mode-hook #'eglot-ensure)

(global-auto-revert-mode t)

(bind-key* "C-c s" 'eglot-code-actions)
(bind-key* "C-c C-r" 'eglot-rename)

(defun dired-notes ()
  (interactive)
  (dired "~/Documents/Notes")
  )

(defun dired-home ()
  (interactive)
  (dired "~")
  )

(bind-key* "C-c nh" 'dired-home)
(bind-key* "C-c nd" 'dired-notes)

(which-key-mode t)

(setq vc-follow-symlinks t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq epg-pinentry-mode 'loopback)

(savehist-mode t)

(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode t)

;; Source - https://stackoverflow.com/a/22176971
;; Posted by user2053036, modified by community. See post 'Timeline' for change history
;; Retrieved 2026-06-20, License - CC BY-SA 3.0

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
(require 'project)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(package-initialize)

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))

(setq use-short-answers t)
(setq use-package-always-ensure t)

(use-package multiple-cursors)
(require 'multiple-cursors)

(bind-key* "C-c y e l" 'mc/edit-lines)
(bind-key* "M-o" 'mc/mark-all-like-this)
(bind-key* "C-c y w l" 'mc/mark-all-words-like-this)
(bind-key* "C-c y s l" 'mc/mark-all-symbols-like-this)

(use-package markdown-mode)
(use-package nerd-icons)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode))
(add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)
(use-package exec-path-from-shell)
(use-package doom-modeline)
(use-package company)
(global-company-mode t)

(use-package lua-mode)
(add-to-list 'auto-mode-alist '("\\.luau\\'" . lua-mode))
(use-package ghostel
  :bind (("C-c m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; ;; Simulate this behavior in ghostel by sending C-p and C-n
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


(use-package doom-themes)

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(bind-key* "C-c e" 'eshell)

;;(setq eshell-destroy-buffer-when-process-dies t)
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook #'(lambda ()
			     (visual-line-mode t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("c4df9006b9eb32599d758800a32f3487c2cdf13826084511783b47d419024af2"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a"
     "5f5770ecd10cb9a93f2df4bd05a5d6102892941cf2795eaffa4ed24d78e5a6f6"
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
 '(eshell-cmpl-ignore-case t)
 '(eshell-mode-hook
   '(#[nil
       ((if (member "tinydash" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "tinydash" eshell-visual-commands)))
	(if (member "fzf" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "fzf" eshell-visual-commands)))
	(if (member "codex" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "codex" eshell-visual-commands)))
	(if (member "cmatrix" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "cmatrix" eshell-visual-commands)))
	(if (eq system-type 'gnu/linux)
	    (progn (ghostel-eshell-visual-command-mode)))
	(setenv "GPG_TTY"
		(shell-command-to-string "/bin/sh tty 2>/dev/null")))
       (t)]))
 '(evil-undo-system 'undo-redo)
 '(marginalia-mode t)
 '(org-agenda-files '("~/Documents/Notes/"))
 '(package-selected-packages
   '(all-the-icons catppuccin-theme colorful-mode company doom-modeline
		   doom-themes eshell-prompt-extras
		   exec-path-from-shell ghostel lua-mode marginalia
		   markdown-mode multiple-cursors
		   nerd-icons-completion nerd-icons-dired orderless
		   org-superstar solarized-theme vertico))
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(send-mail-function 'mailclient-send-it)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#202326" :foreground "#fcfcfc"))))
 '(ansi-color-blue ((t (:background "blue" :foreground "blue"))))
 '(ansi-color-bright-black ((t (:background "dim gray" :foreground "dim gray"))))
 '(ansi-color-bright-blue ((t (:background "deep sky blue" :foreground "deep sky blue"))))
 '(ansi-color-bright-cyan ((t (:background "medium spring green" :foreground "medium spring green"))))
 '(ansi-color-bright-green ((t (:background "spring green" :foreground "spring green"))))
 '(ansi-color-bright-magenta ((t (:background "magenta" :foreground "magenta"))))
 '(ansi-color-bright-red ((t (:background "red" :foreground "red"))))
 '(ansi-color-bright-yellow ((t (:background "yellow" :foreground "yellow"))))
 '(ansi-color-cyan ((t (:background "cyan" :foreground "cyan"))))
 '(ansi-color-green ((t (:background "green" :foreground "green"))))
 '(ansi-color-magenta ((t (:background "magenta" :foreground "magenta"))))
 '(ansi-color-red ((t (:background "red" :foreground "red"))))
 '(ansi-color-white ((t (:background "white smoke" :foreground "white smoke"))))
 '(ansi-color-yellow ((t (:background "gold" :foreground "gold"))))
 '(button ((t (:foreground "red" :underline "red"))))
 '(doom-modeline-bar ((t (:background "red"))))
 '(epa-string ((t (:foreground "red"))))
 '(eshell-ls-archive ((t (:foreground "dark orange"))))
 '(eshell-ls-directory ((t (:foreground "orange red"))))
 '(eshell-ls-executable ((t (:foreground "gold"))))
 '(eshell-ls-special ((t (:foreground "tomato"))))
 '(font-lock-builtin-face ((t (:inherit modus-themes-bold :foreground "orange red"))))
 '(font-lock-comment-face ((t (:inherit modus-themes-slant :foreground "#525961"))))
 '(font-lock-constant-face ((t (:foreground "red"))))
 '(font-lock-doc-face ((t (:inherit modus-themes-slant :foreground "red"))))
 '(font-lock-doc-markup-face ((t (:inherit modus-themes-slant :foreground "red"))))
 '(font-lock-function-name-face ((t (:foreground "orange red"))))
 '(font-lock-keyword-face ((t (:inherit modus-themes-bold :foreground "light coral"))))
 '(font-lock-preprocessor-face ((t (:foreground "orange red"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit modus-themes-bold :foreground "orange"))))
 '(font-lock-regexp-grouping-construct ((t (:inherit modus-themes-bold :foreground "orange"))))
 '(font-lock-string-face ((t (:foreground "red"))))
 '(font-lock-type-face ((t (:inherit modus-themes-bold :foreground "orange red"))))
 '(font-lock-variable-name-face ((t (:foreground "tomato"))))
 '(fringe ((t (:background "#202326" :foreground "#fcfcfc"))))
 '(highlight ((t (:background "red" :foreground "#ffffff"))))
 '(line-number ((t (:inherit default :background "#191c1e" :foreground "#fcfcfc"))))
 '(line-number-current-line ((t (:inherit (bold line-number) :background "#23272a" :foreground "#ffffff"))))
 '(marginalia-documentation ((t (:inherit modus-themes-slant :foreground "gainsboro"))))
 '(marginalia-string ((t (:foreground "#fcfcfc"))))
 '(mode-line ((t (:inherit modus-themes-ui-variable-pitch :background "#191c1e" :foreground "#fcfcfc" :box (:line-width (1 . 1) :color "#191c1e")))))
 '(mode-line-inactive ((t (:inherit modus-themes-ui-variable-pitch :background "#1d2123" :foreground "#e6e6e6" :box (:line-width (1 . 1) :color "#1d2123")))))
 '(modus-themes-completion-match-0 ((t (:inherit bold :foreground "orange"))) t)
 '(modus-themes-completion-selected ((t (:inherit bold :background "red"))) t)
 '(modus-themes-prompt ((t (:foreground "orange red"))) t)
 '(modus-themes-search-current ((t (:background "red" :foreground "#ffffff"))) t)
 '(modus-themes-search-lazy ((t (:background "red" :foreground "#ffffff"))) t)
 '(org-level-1 ((t (:inherit outline-1 :height 1.25))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.15))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.05))))
 '(org-tag ((t (:foreground "orange"))))
 '(success ((t (:inherit bold :foreground "gold")))))
