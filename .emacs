;; Enable ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Eglot
(require 'eglot) ; Eglot is now built into emacs

(add-hook 'typescript-mode-hook #'eglot-ensure)
(add-hook 'js-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'rust-mode-hook #'eglot-ensure)

;; Enable line numbers
(global-display-line-numbers-mode +1)

;; Clean up the UI
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; Windmove
(global-set-key (kbd "M-h") #'windmove-left)
(global-set-key (kbd "M-l") #'windmove-right)
(global-set-key (kbd "M-k") #'windmove-up)
(global-set-key (kbd "M-j") #'windmove-down)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Make emacs not annoying
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq tramp-auto-save-directory "/tmp")

;; Packages
(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package magit
  :bind ("C-c g" . magit-status))

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "pandoc"))

(use-package typescript-mode
  :mode "\\.ts\\'")

(use-package lua-mode
  :mode "\\.lua\\'")

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package tokyonight-themes
  :vc (:url "https://github.com/xuchengpeng/tokyonight-themes"))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode))

;; Keys
(global-unset-key (kbd "C-x C-b")) ;; C-x b is a lot more useful
(global-unset-key (kbd "C-x C-d")) ;; C-x d is a lot more useful

;; Font
(set-face-attribute 'default nil :height 140)

;; Custom
(setq custom-file "~/.emacs.custom.el")
(load custom-file)
