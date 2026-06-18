(setq custom-file (make-temp-file "emacs-custom"))

(setq vc-follow-symlinks t)

(setq-default scroll-conservatively 101)

(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-width 4)

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

(use-package "systemd")
(use-package "markdown-mode")
(use-package "rust-mode")
(use-package "exec-path-from-shell")
(use-package "catppuccin-theme")
(use-package "fish-mode")
(use-package "vterm" :defer t)
(use-package "spaceline")
(use-package "magit" :defer t)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(setq catppuccin-flavor 'frappe)
(load-theme 'catppuccin :no-confirm)

(add-hook 'org-mode-hook #'(lambda ()
                             ;; make the lines in the buffer wrap around the edges of the screen.
                             
                             ;; to press C-c q  or fill-paragraph ever again!
                             (visual-line-mode t)
                             (org-indent-mode t)))

(global-set-key (kbd "C-c t") 'vterm)
(with-eval-after-load 'dired
  (require 'dired-x))
(add-hook 'dired-mode-hook 'dired-omit-mode)
