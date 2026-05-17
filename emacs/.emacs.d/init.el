;;; Load paths
(add-to-list 'custom-theme-load-path "~/.emacs.d/local")
(add-to-list 'load-path "~/.emacs.d/local")

;;; Make Emacs not put backup files in the same directory
(setq backup-directory-alist `(("." . "~/.saves")))

;;; Vterm
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package vterm
    :ensure t)

;;; Open home dir with a keybind
(global-set-key (kbd "C-c h") (lambda () (interactive) (dired "~")))

;;; Terminal
(global-set-key (kbd "C-c t") #'vterm)

;;; Which-key
(which-key-mode t)

;;; Font
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font-18"))
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font-18")

;;; Fix the stupid query replace keybinds
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c g") 'query-replace-regexp)

;;; Exec path from shell
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;; Don't show splash screen
(setq inhibit-splash-screen t)

;;; Fix indentation
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4)

(add-hook 'makefile-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 8)))

;;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'fundamental-mode-hook #'display-line-numbers-mode)

;;; Clean up UI
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;;; Pixel scrolling
(pixel-scroll-precision-mode t)

;;; Follow vc symlinks
(setq vc-follow-symlinks t)

;;; Ido mode
(fido-vertical-mode t)
(savehist-mode t)

;;; Treesitter
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (rust "https://github.com/tree-sitter/tree-sitter-rust")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(dolist (lang '(bash c cpp css html javascript json python rust toml typescript tsx yaml))
  (unless (treesit-language-available-p lang)
    (treesit-install-language-grammar lang)))

(setq major-mode-remap-alist
      '((sh-mode . bash-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (css-mode . css-ts-mode)
        (html-mode . html-ts-mode)
        (javascript-mode . js-ts-mode)
        (js-mode . js-ts-mode)
        (json-mode . json-ts-mode)
        (python-mode . python-ts-mode)
        (rust-mode . rust-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (yaml-mode . yaml-ts-mode)))

;;; LSP
(add-hook 'c-ts-mode-hook #'eglot-ensure)

;;; Theme
(load-theme 'gruber-darker t)

;;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
