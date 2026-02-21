(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'none)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-display-line-numbers-mode +1)
(menu-bar--display-line-numbers-mode-relative)

(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

(setq inhibit-splash-screen t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq tramp-auto-save-directory "/tmp")

(add-to-list 'exec-path "/opt/local/bin")
(setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))
(provide 'options)
