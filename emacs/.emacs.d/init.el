;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Which-key mode
(which-key-mode t)

;;; Fix gpg
(setq epa-pinentry-mode 'loopback)

;;; Save history
(savehist-mode t)

;;; Set the custom-file
(setq custom-file "~/.emacs.d/custom.el")

;;; Follow git symlinks
(setq vc-follow-symlinks t)

;;; Fix meta on macOS
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)

;;; Packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(require 'use-package)
(setq use-package-always-ensure t)

;;; Get shell environment variables
(use-package exec-path-from-shell
  :defer t
  )
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))

;;; Magit
(use-package magit
  :defer t
  :bind ("C-x g" . magit-status)
  )

(ignore-error (magit-status))
(ignore-error (magit-bury-buffer t))
(ignore-error (delete-window))

;;; Proper terminal
(use-package eat)
(add-hook 'eshell-load-hook #'eat-eshell-mode)
(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

(global-set-key (kbd "C-x p s") #'eat-project)
(global-set-key (kbd "C-c t") #'eat)

;;; Disable UI clutter
(menu-bar-mode 0)
(if (fboundp 'tool-bar-mode) (tool-bar-mode 0))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))
(setq inhibit-splash-screen t)

;;; Don't clutter the directory with random files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;; Font
(add-to-list 'default-frame-alist '(font . "Iosevka-14"))

;;; Visual line mode
(global-visual-line-mode t)

;;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'fundamental-mode-hook (lambda () (display-line-numbers-mode 1)))

;;; Fix indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Use short answers
(setq use-short-answers t)

;;; Load the custom-file
(load custom-file)

;;; Simple C mode
(add-to-list 'load-path "~/.emacs.d/local")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
