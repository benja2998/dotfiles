;; -*- lexical-binding: t; -*-

(setq custom-file "~/.emacs.custom.el")

;;; For future customizations
(require 'eshell)
(require 'dired)

;;; Local packages
(add-to-list 'load-path (concat user-emacs-directory "local/"))

(defun daily-note ()
  "Open today's daily note"
  (interactive)
  (setq current-date-file (concat "~/Documents/Notes/" (format-time-string "%Y" (current-time)) "/" (format-time-string "%d-%m-%Y" (current-time)) ".org"))
  (setq current-date (format-time-string "%d-%m-%Y" (current-time)))
  (find-file current-date-file)
  (unless (file-exists-p current-date-file)
    (insert (concat "* " current-date (format "\n")))))

(defun org-insert-backlink ()
  "Insert a backlink"
  (interactive)
  (setq insert-backlink--files (directory-files-recursively "~/Documents/Notes/" "\\.org$"))
  (setq insert-backlink--file (completing-read "Note to backlink to: " insert-backlink--files nil t))
  (setq insert-backlink--pretty (read-from-minibuffer "Description: "))
  (cond ((string-equal insert-backlink--pretty "")
	 (setq insert-backlink--pretty insert-backlink--file)))
  (insert (format "[[%s][%s]]" insert-backlink--file insert-backlink--pretty)))

(defun my/compile ()
  "Compile"
  (interactive)
  (call-interactively 'compile))

(defun org-insert-image ()
  "Insert a image"
  (interactive)
  (setq insert-image--files (directory-files-recursively "~/Pictures/" "\\.png$"))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.jpeg$")))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.jpg$")))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.webp$")))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.tiff$")))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.bmp$")))
  (setq insert-image--files (append insert-image--files
				    (directory-files-recursively "~/Pictures/" "\\.gif$")))
  (setq insert-image--file (completing-read "Image to insert: " insert-image--files nil t))
  (insert (format "[[%s]]" insert-image--file)))

(defun dired-dailies ()
  "List daily notes"
  (interactive)
  ;; Should be trivial due to wildcards
  (dired "~/Documents/Notes/**/*-*-*.org"))

(defun my/insert-code ()
  "Insert org code block"
  (interactive)
  (setq code--lang (read-from-minibuffer "Language: "))
  (catch 'no-language
    (cond ((string-equal code--lang "")
	   (throw 'no-language "No language provided"))))

  (insert (format "#+BEGIN_SRC %s\n#+END_SRC" code--lang))
  (previous-line)
  (call-interactively 'move-end-of-line)
  (newline)
  (indent-for-tab-command))

(defun search-in-notes ()
  "Search in notes"
  (interactive)
  (setq search--whatIread (read-from-minibuffer "Enter search term (regex, case-insensitive): "))
  (grep (format "grep -rnEi \"%s\" ~/Documents/Notes" search--whatIread)))

(defun my/project-search ()
  "Search in project"
  (interactive)
  (setq search--whatIread (read-from-minibuffer "Enter search term (regex, case-insensitive): "))
  (setq this--project-root (project-root (project-current)))
  (grep (format "grep -rnEi \"%s\" %s --exclude-dir \".git/\""
		search--whatIread
		this--project-root
		this--project-root)))

(defun todo-note ()
  "Open todo.org note"
  (interactive)
  (find-file "~/Documents/Notes/todo.org"))

(defun dired-videos ()
  "Open videos directory"
  (interactive)
  (dired "~/Videos"))

(defun dired-music ()
  "Open music directory"
  (interactive)
  (dired "~/Music"))

;;; Smooth scrolling with mouse or trackpad
(pixel-scroll-precision-mode t)

;;; Scroll conservatively
(setq scroll-conservatively 101)

;;; Bind-key is the modern way to bind keys
(require 'bind-key)

;;; Keybinds
(bind-key* "C-c nj" 'my/compile)
(bind-key* "C-c nt" 'daily-note)
(bind-key* "C-c tn" 'todo-note)
(bind-key* "C-c ne" 'org-agenda-list)
(bind-key* "C-x ps" 'my/project-search) ;; project-shell is useless
(bind-key* "C-c ny" 'dired-videos)
(bind-key* "C-c ld" 'dired-dailies)
(bind-key* "C-c ls" 'search-in-notes)
(bind-key* "C-c nm" 'dired-music)
(bind-key* "C-x M-c M-b u t t e r f l y" 'butterfly)

;;; Repeat mode
(repeat-mode t)

;;; Better than using Meta + Arrows
(with-eval-after-load 'org
  (bind-key "C-c ib" #'org-insert-backlink 'org-mode-map)
  (bind-key "C-c ic" #'my/insert-code 'org-mode-map)
  (bind-key "C-c ii" #'org-insert-image 'org-mode-map)  
  (bind-key "M-l" #'org-do-demote 'org-mode-map)
  (bind-key "M-h" #'org-do-promote 'org-mode-map))

(defun eshell-clear ()
  "Clear interactively eshell"
  (interactive)
  (execute-kbd-macro (kbd "cls RET")))

;;; Fix for eshell-mode-map not working immediately
(defun bind-eshell-clear-mode-map ()
  (interactive)
  (bind-key "C-l" #'eshell-clear 'eshell-mode-map)
  ;; This shouldn't be in the function for Eshell but I put it here to not repeat this
  (bind-key "C-c C-c" 'wdired-change-to-wdired-mode 'dired-mode-map))
(add-hook 'emacs-startup-hook #'bind-eshell-clear-mode-map)

;;; Infinite history
(setq eshell-history-size 999999)

;;; Shared history in the eshell
(setq eshell-history-append t)
(setq eshell-save-history-on-exit nil)
(setq eshell-hist-ignoredups t)
(add-hook 'eshell-pre-command-hook (lambda ()
				     (eshell-write-history eshell-history-file-name t)
				     (eshell-read-history eshell-history-file-name t)))

;;; Respect editorconfig files
(editorconfig-mode t)

;;; Automatically revert buffers
(global-auto-revert-mode t)

(defun dired-notes ()
  "Open notes directory"
  (interactive)
  (dired "~/Documents/Notes"))

(defun dired-home ()
  "Open home directory"
  (interactive)
  (dired "~"))

;;; Keybinds
(bind-key* "C-c nh" 'dired-home)
(bind-key* "C-c nd" 'dired-notes)

;;; Which-key (built into emacs)
(which-key-mode t)

;;; Auto-follow symlinks
(setq vc-follow-symlinks t)

;;; Clean up the UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq epg-pinentry-mode 'loopback)

(savehist-mode t)

(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode t)

;;; Make emacs not annoying
(dolist (dir '("auto-save" "locks" "backups"))
  (make-directory (expand-file-name dir user-emacs-directory) t))
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))
(setq lock-file-name-transforms
      `((".*" ,(concat user-emacs-directory "locks/") t)))
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;;; Font
(cond ((eq system-type 'gnu/linux)
       (add-to-list 'default-frame-alist '(font . "Iosevka-20")))
      ((eq system-type 'android)
       (add-to-list 'default-frame-alist '(font . "monospace-24"))))

(setq display-line-numbers-type 'relative)

(pixel-scroll-precision-mode t)

(require 'package)
(require 'project)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(package-initialize)

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))

(setq use-short-answers t)
(setq use-package-always-ensure t)

(use-package modus-themes-exporter
  :ensure nil ; do not try to install because we get it from source in the `:init'
  :commands (modus-themes-exporter-export)
  :init
  ;; Then upgrade it with the command `package-vc-upgrade' or `package-vc-upgrade-all'.
  (unless (package-installed-p 'modus-themes-exporter)
    (package-vc-install "https://github.com/protesilaos/modus-themes-exporter.git")))

(use-package modus-themes)
(use-package magit)

(use-package multiple-cursors)
(require 'multiple-cursors)

(bind-key* "C-c y e l" 'mc/edit-lines)
(bind-key* "M-o" 'mc/mark-all-like-this)
(bind-key* "C-c y w l" 'mc/mark-all-words-like-this)
(bind-key* "C-c y s l" 'mc/mark-all-symbols-like-this)

(use-package dmenu)
(use-package markdown-mode)
(use-package exec-path-from-shell)
(use-package rust-mode)
(use-package lua-mode)
(use-package package-lint)

(use-package org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(defun my/audio-vol-up () (interactive)
       (start-process-shell-command
	"vol-up" nil
	"pactl set-sink-volume @DEFAULT_SINK@ +5%"))

(defun my/audio-vol-down () (interactive)
       (start-process-shell-command
	"vol-down" nil
	"pactl set-sink-volume @DEFAULT_SINK@ -5%"))

(defun my/audio-mute () (interactive)
       (start-process-shell-command
	"vol-mute" nil
	"pactl set-sink-mute @DEFAULT_SINK@ toggle"))

;; Brightness keys (requires `light`)
(defun my/brightness-up () (interactive)
       (start-process-shell-command
	"bright-up" nil
	"light -A 5"))

(defun my/brightness-down () (interactive)
       (start-process-shell-command
	"bright-down" nil
	"light -U 5"))

(defun run-wiremix ()
  (interactive)
  (ghostel-eshell--exec-visual "wiremix"))

(defun run-nmtui ()
  (interactive)
  (ghostel-eshell--exec-visual "nmtui"))

(defun run-boomer ()
  (interactive)
  (start-process-shell-command
   "boomer" nil "/home/benjamin/Thirdparty/boomer/boomer"))

(defun run-htop ()
  (interactive)
  (ghostel-eshell--exec-visual "htop"))

(defun run-librewolf ()
  (interactive)
  (start-process-shell-command
   "librewolf" nil "io.gitlab.librewolf-community"))

(defun run-xsecurelock ()
  (interactive)
  (start-process-shell-command
   "xsecurelock" nil "xsecurelock"))

(defun run-flameshot ()
  (interactive)
  (start-process-shell-command
   "flameshot" nil "flameshot gui"))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package exwm)
(require 'exwm)
;; Set the initial workspace number.
(setq exwm-workspace-number 10)

;; Make class name the buffer name.
(add-hook 'exwm-update-class-hook
	  (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;; Global keybindings.
(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset) ;; s-r: Reset (to line-mode).
        ([?\s-w] . exwm-workspace-switch) ;; s-w: Switch workspace.
        ([?\s-i] . exwm-input-toggle-keyboard) ;; s-i: Toggle char mode.
        ([?\s-j] . run-flameshot) ;; s-j: Run flameshot
        ([?\s-p] . my/audio-vol-up) ;; s-p: Volume up.
        ([?\s-q] . dmenu) ;; s-q: Dmenu.
        ([?\s-n] . run-wiremix) ;; s-n: Wiremix.
        ([?\s-a] . run-librewolf) ;; s-a: Librewolf.	
        ([?\s-b] . run-nmtui) ;; s-b: Nmtui.
        ([?\s-h] . run-htop) ;; s-h: Htop.
        ([?\s-c] . exwm-workspace-move-window) ;; s-c: Move window to workspace.
        ([?\s-z] . run-boomer) ;; s-z: Boomer.
	([?\s-y] . run-xsecurelock) ;; s-y: Xsecurelock.
        ([?\s-u] . my/audio-vol-down) ;; s-u: Volume down.
        ([?\s-l] . my/brightness-up) ;; s-l: Brightness up.
        ([?\s-d] . my/brightness-down) ;; s-d: Brightness down.
        ([?\s-m] . my/audio-mute) ;; s-m: Mute volume.
        ([?\s-&] . (lambda (cmd) ;; s-&: Launch application.
                     (interactive (list (read-shell-command "$ ")))
                     (start-process-shell-command cmd nil cmd)))
        ;; s-N: Switch to certain workspace.
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))

(add-to-list 'auto-mode-alist '("\\.luau\\'" . lua-mode))

(setq display-time-format "%Y-%m-%d %a %H:%M")
(display-time-mode 1)
(display-battery-mode 1)

(cond ((eq system-type 'gnu/linux)
       (exwm-wm-mode)
       (exwm-systemtray-mode 1)))

(use-package ghostel
  :bind (("C-c m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; Simulate this behavior in ghostel by sending C-p and C-n
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

(use-package ghostel-compile
  :ensure nil
  :hook (after-init . ghostel-compile-global-mode))
(use-package ghostel-comint
  :ensure nil
  :hook (after-init . ghostel-comint-global-mode))

(use-package neofetch
  :vc (:url "https://codeberg.org/benja2998/neofetch.el"
	    :branch "main"))

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

(bind-key* "C-c e" 'eshell)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "flatpak"
      browse-url-generic-args '("run" "io.gitlab.librewolf-community"))

(setq eshell-destroy-buffer-when-process-dies nil)
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook (lambda ()
			   (setq word-wrap t)
			   (setq truncate-lines nil)
			   (setq truncate-partial-width-windows nil)))

(setq org-directory "~/Documents/Notes/")
(setq org-agenda-files (list org-directory))

(load custom-file t)
