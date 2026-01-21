;; Enable ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Enable line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

;; Clean up the UI
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

;; Windmove
(windmove-default-keybindings 'meta)

;; Custom
(setq custom-file "~/.emacs.custom.el")
(load custom-file)
