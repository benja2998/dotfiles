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
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font-12"))
(set-face-attribute 'default nil :font "JetBrainsMonoNL Nerd Font-12")

;;; Fix the stupid query replace keybinds
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c g") 'query-replace-regexp)

;;; Exec path from shell
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;; Don't show splash screen
(setq inhibit-splash-screen t)

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
      '((bash "https://github.com/tree-sitter/tree-sitter-bash" "v0.23.3")
        (c "https://github.com/tree-sitter/tree-sitter-c" "v0.23.5")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")
        (css "https://github.com/tree-sitter/tree-sitter-css" "v0.23.2")
        (html "https://github.com/tree-sitter/tree-sitter-html" "v0.23.2")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "v0.23.1" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json" "v0.24.8")
        (python "https://github.com/tree-sitter/tree-sitter-python" "v0.23.6")
        (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.2")
        (toml "https://github.com/tree-sitter-grammars/tree-sitter-toml" "v0.7.0")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.23.2" "tsx/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml" "v0.7.0")))

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

;;; Fix indentation
(setq-default indent-tabs-mode nil
              tab-width 4
              standard-indent 4)

(setq c-basic-offset 4
      c-ts-mode-indent-offset 4
      css-indent-offset 4
      js-indent-level 4
      json-ts-mode-indent-offset 4
      python-indent-offset 4
      rust-ts-mode-indent-offset 4
      sgml-basic-offset 4
      sh-basic-offset 4
      toml-ts-mode-indent-offset 4
      typescript-ts-mode-indent-offset 4)

(add-hook 'makefile-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode t)
            (setq-local tab-width 8)))

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
