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

;; Enable line numbers
(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

;; Clean up the UI
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; Windmove
(windmove-default-keybindings 'meta)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Make emacs not annoying
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Use tabs
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

;; Enforce tabs everywhere
(add-hook 'prog-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)))

(add-hook 'text-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
			(setq tab-width 4)))

(setq c-basic-offset 4)

;; Packages
(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
  :mode "\\.ts\\'"
  :hook (typescript-mode . (lambda ()
                              (setq indent-tabs-mode t)
                              (setq tab-width 4))))

(use-package lua-mode
  :mode "\\.lua\\'"
  :hook (lua-mode . (lambda ()
                              (setq indent-tabs-mode t)
                              (setq tab-width 4))))

;; Custom
(setq custom-file "~/.emacs.custom.el")
(load custom-file)
