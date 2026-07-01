;; -*- lexical-binding: t; -*-

(editorconfig-mode t)

(global-set-key (kbd "M-h") #'windmove-left)
(global-set-key (kbd "M-j") #'windmove-down)
(global-set-key (kbd "M-k") #'windmove-up)
(global-set-key (kbd "M-l") #'windmove-right)

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
(use-package company)

(require 'eglot)
(add-hook 'prog-mode-hook #'eglot-ensure)

(require 'company)
(global-company-mode t)

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
 '(custom-enabled-themes '(arcdark))
 '(custom-safe-themes
   '("4db745f7ba0382641879fa0d22bf7fd0d508e3097325e588aeaa999930a69c96"
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
 '(package-selected-packages
   '(company exec-path-from-shell ghostel god-mode magit markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
