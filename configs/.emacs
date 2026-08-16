;; -*- lexical-binding: t; -*-

;;; Dired dwim
(setq dired-dwim-target t)

;;; Emacs + termux
(cond ((eq system-type 'android)
       (setenv "PATH" (format "%s:%s" "/data/data/com.termux/files/usr/bin"
			      (getenv "PATH")))
       (push "/data/data/com.termux/files/usr/bin" exec-path)))

;;; Don't edit my config
(setq custom-file "~/.emacs-custom-not-loaded")

;;; st
(defvar eshell-interpreter-alist)
(defvar eshell-destroy-buffer-when-process-dies)

(defun eshell/st-or-ghostel ()
  "ST or ghostel"
  (interactive)
  (cond ((eq system-type 'gnu/linux)
	 (start-process-shell-command
	  "st" nil "st"))
	(t
	 (ghostel))))

(defun st-project ()
  "ST rpoject"
  (interactive)
  (project-dired)
  (setq mydired--buffer-name (buffer-name))
  (start-process-shell-command
   "st" nil "st")
  (kill-buffer mydired--buffer-name))

(defun st-exec-visual (&rest args)
  "Replacement for `eshell-exec-visual' that dispatches to st.
ARGS are the program name followed by its arguments, as passed by
eshell."
  (let* (eshell-interpreter-alist
	 (interp (eshell-find-interpreter (car args) (cdr args)))
	 (program (car interp))
	 (args (flatten-tree
		(eshell-stringify-list (append (cdr interp)
					       (cdr args)))))
	 (term-buf
	  (generate-new-buffer
	   (concat "*" (file-name-nondirectory program) "*")))
	 (eshell-buf (current-buffer))
	 (prog-cmdline (concat "bash -c 'sleep 0.01; "program " " (eshell-list-to-string args) "'")))
    (save-current-buffer
      (start-process-shell-command
       "st-eshell" nil (concat "st " prog-cmdline))
      (kill-buffer term-buf)))
  nil)

(define-minor-mode st-eshell-visual-command-mode
  "Run Eshell visual commands (vim, htop, less, ...) in st buffers.
When enabled, `eshell-exec-visual' is overridden to launch the
program in a dedicated st terminal buffer.  When the program
exits, the buffer stays on `[Process exited]' so any remaining
output is visible; press `q' to dismiss it.  Set
`eshell-destroy-buffer-when-process-dies' to non-nil to kill the
buffer automatically on exit instead."
  :global t
  :group 'ghostel
  (if st-eshell-visual-command-mode
      (advice-add 'eshell-exec-visual :override
                  #'st-exec-visual)
    (advice-remove 'eshell-exec-visual
                   #'st-exec-visual)))

;;; For future customizations
(require 'eshell)
(require 'dired)

;;; Local packages
(add-to-list 'load-path (concat user-emacs-directory "local/"))
(require 'emacs-multi-eshell)

;;; Functions
(defun android-insert-tilde ()
  "Fix for my android physical keyboard inserting the small tilde instead of ~"
  (interactive)
  (insert "~"))
(bind-key* "˜" 'android-insert-tilde)
(defun eshell/z (&optional &rest ARGS)
  "Zoxide implementation for Eshell.  Optionally takes in ARGS, which will be passed to Zoxide"
  (interactive)

  (let* ((args (if ARGS
		   (eshell-list-to-string (flatten-tree ARGS))
		 (getenv "HOME")))
	 (output (string-trim
		  (shell-command-to-string
		   (concat "zoxide query " args)))))
    (cond

     ;; if it is -, go back
     ((string-equal args "-")
      (eshell/cd "-"))

     ;; if it exists, just cd to it and try to add it
     ((file-directory-p args)
      (shell-command-to-string
       (concat "zoxide add " args))
      (eshell/cd args))

     ;; until I can find a better way to check for it finding nothing,
     ;; this relies on zoxide's output format staying the same
     ;;
     ;; this one might be redundant with the clause above,
     ;; but I will keep it just to be safe
     ((string-equal output "zoxide: no match found")
      (shell-command-to-string
       (concat "zoxide add " args))
      (eshell/cd args))

     ;; if zoxide found it, cd to it
     (t
      (eshell/cd output)))))

(defun notes-eshell ()
  "Open notes-eshell"
  (interactive)
  (cond ((get-buffer "*notes-eshell*")
	 (switch-to-buffer "*notes-eshell*"))
	(t
	 (dired-notes)
	 (setq mydired--buffer-name (buffer-name))
	 (ees/eshell-new)
	 (rename-buffer "*notes-eshell*")
	 (kill-buffer mydired--buffer-name))))

(defun videos-eshell ()
  "Open videos-eshell"
  (interactive)
  (cond ((get-buffer "*videos-eshell*")
	 (switch-to-buffer "*videos-eshell*"))
	(t
	 (dired "~/Videos")
	 (setq mydired--buffer-name (buffer-name))
	 (ees/eshell-new)
	 (rename-buffer "*videos-eshell*")
	 (kill-buffer mydired--buffer-name))))

(defun pictures-eshell ()
  "Open pictures-eshell"
  (interactive)
  (cond ((get-buffer "*pictures-eshell*")
	 (switch-to-buffer "*pictures-eshell*"))
	(t
	 (dired "~/Pictures")
	 (setq mydired--buffer-name (buffer-name))
	 (ees/eshell-new)
	 (rename-buffer "*pictures-eshell*")
	 (kill-buffer mydired--buffer-name))))

(defun eshell-in-home ()
  "Open eshell in home"
  (interactive)
  (dired-home)
  (setq mydired--buffer-name (buffer-name))
  (ees/eshell-new)
  (kill-buffer mydired--buffer-name))

(defun my/setup-workspaces ()
  (exwm-workspace-switch 1)
  (run-librewolf)
  (exwm-workspace-switch 6)
  (eshell-in-home)
  (exwm-workspace-switch 7)
  (pictures-eshell)
  (exwm-workspace-switch 8)
  (videos-eshell)
  (exwm-workspace-switch 9)
  (notes-eshell)
  (exwm-workspace-switch 0))

(defun daily-note ()
  "Open today's daily note"
  (interactive)
  (setq current-date-file (concat
			   "~/Documents/Notes/"
			   (format-time-string "%Y" (current-time))
			   "/"
			   (format-time-string "%d-%m-%Y" (current-time)) ".org"))
  (setq current-date (format-time-string "%d-%m-%Y" (current-time)))
  (find-file current-date-file)
  (setq current-day (format-time-string "%A" (current-time)))
  (unless (file-exists-p current-date-file)
    (insert (concat "* " current-date " " current-day (format "\n")))))
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

;;; Scroll conservatively
(setq scroll-conservatively 101)

;;; Bind-key is the modern way to bind keys
(require 'bind-key)

;;; Keybinds
(bind-key* "C-c nj" 'my/compile)
(bind-key* "C-x M-p" 'mark-paragraph)
(bind-key* "C-c nv" 'visit-tags-table)
(bind-key* "C-c ns" 'select-tags-table)
(bind-key* "C-c j" 'eshell-in-home)
(bind-key* "C-c k" 'notes-eshell)
(bind-key* "C-c nt" 'daily-note)
(bind-key* "C-c tn" 'todo-note)
(bind-key* "C-c ne" 'org-agenda-list)
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
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  (bind-key "C-c ic" #'my/insert-code 'org-mode-map)
  (bind-key "C-c ii" #'org-insert-image 'org-mode-map)
  (bind-key "C-x M-l" #'org-do-demote 'org-mode-map)
  (bind-key "C-x M-h" #'org-do-promote 'org-mode-map))

;;; Function to clear eshell
(defun eshell-clear ()
  "Clear interactively eshell"
  (interactive)
  (execute-kbd-macro (kbd "cls RET")))

;;; Fix for eshell-mode-map not working immediately
(defun bind-eshell-clear-mode-map ()
  (interactive)
  (bind-key "M-j" #'eshell-clear 'eshell-mode-map)
  ;; This shouldn't be in the function for Eshell but I put it here to not repeat this
  (bind-key "C-c C-c" 'wdired-change-to-wdired-mode 'dired-mode-map))
(add-hook 'emacs-startup-hook #'bind-eshell-clear-mode-map)

;;; bigger history
(setq eshell-history-size 1000)

;;; Shared history in the eshell
(setq eshell-history-append t)
(setq eshell-save-history-on-exit nil)
(setq eshell-hist-ignoredups t)
(add-hook 'eshell-post-command-hook (lambda ()
				     (eshell-write-history eshell-history-file-name t)
				     (eshell-read-history eshell-history-file-name t)))

;;; Respect editorconfig files
(editorconfig-mode t)

;;; Automatically revert buffers
(global-auto-revert-mode t)

;;; Functions to open notes and home
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

;;; Delete trailing whitespace on write file
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;;; EPG pinentry
(setq epg-pinentry-mode 'loopback)

;;; Save minibuffer history
(savehist-mode t)

;;; Inhibit splash screen
(setq inhibit-splash-screen t)
;;; Not sure if this is necessary
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
       (add-to-list 'default-frame-alist '(font . "Iosevka-24"))))

;;; Relative line numbers
(setq display-line-numbers-type 'relative)

;;; Package configuration
(require 'package)
(require 'project)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(package-initialize)

;;; Only enable line numbers when it makes sense
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))

;;; Use short answers
(setq use-short-answers t)

;;; Always ensure t
(setq use-package-always-ensure t)

;;; Modus themes exporter
(use-package modus-themes-exporter
  :ensure nil ; do not try to install because we get it from source in the `:init'
  :commands (modus-themes-exporter-export)
  :init
  ;; Then upgrade it with the command `package-vc-upgrade' or `package-vc-upgrade-all'.
  (unless (package-installed-p 'modus-themes-exporter)
    (package-vc-install "https://github.com/protesilaos/modus-themes-exporter.git")))
(use-package modus-themes)

;;; The best git client
(use-package magit)

;; Inputrc mode
(use-package inputrc-mode)

;;; multiple-cursors configuration
(use-package multiple-cursors)
(require 'multiple-cursors)
(bind-key* "C-c y e l" 'mc/edit-lines)
(bind-key* "M-o" 'mc/mark-all-like-this)
(bind-key* "C-c y w l" 'mc/mark-all-words-like-this)
(bind-key* "C-c y s l" 'mc/mark-all-symbols-like-this)

;;; Eshell fish-like completion
(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)

;;; Dmenu
(use-package dmenu)
;;; Markdown support
(use-package markdown-mode)
;;; exec-path-from-shell
(use-package exec-path-from-shell)
;;; Rust support
(use-package rust-mode)
;;; Lua support
(use-package lua-mode)
;;; Package linter
(use-package package-lint)

;;; Functions for EXWM keybinds to call
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
  (st-exec-visual "wiremix"))
(defun run-nmtui ()
  (interactive)
  (st-exec-visual "nmtui"))
(defun run-boomer ()
  (interactive)
  (start-process-shell-command
   "boomer" nil "/home/benjamin/Thirdparty/boomer/boomer"))
(defun run-htop ()
  (interactive)
  (st-exec-visual "htop"))
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
(defun opsec-leak ()
  (interactive)
  (start-process-shell-command
   "opsec" nil "espeak-ng \"OPSEC LEAK\""))

;;; org superstar
(use-package org-superstar)
(add-hook 'org-mode-hook (lambda ()
			   (org-superstar-mode 1)
			   (org-indent-mode 1)))

;;; dashboard
(use-package dashboard)
(require 'dashboard)
(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)))
(setq initial-buffer-choice 'dashboard-open)

;;; EXWM configuration
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
	([?\s-o] . opsec-leak) ;; s-o: The most important keybind
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

;;; Use lua-mode for luau files
(add-to-list 'auto-mode-alist '("\\.luau\\'" . lua-mode))

;;; Display time and battery in mode-line
(setq display-time-format "%d-%m-%Y %a %H:%M")
(display-time-mode 1)
(display-battery-mode 1)

;;; Enable EXWM
(cond ((eq system-type 'gnu/linux)
       (exwm-wm-mode)
       (exwm-systemtray-mode 1)
       (run-at-time
	"2 sec"
	nil
	'my/setup-workspaces)))

;;; terminal emulator
(use-package ghostel
  :bind (("C-c m" . eshell/st-or-ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; Simulate this behavior in ghostel by sending C-p and C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl")))
	 ;; I use M-j to clear Eshell, so it makes sense to have this
         ("M-j" . (lambda () (interactive) (ghostel-send-key "l" "ctrl")))
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
(setq ghostel-timer-delay 0.007) ; 144 fps

(cond ((eq system-type 'gnu/linux)
       (bind-key* "C-x pm" 'st-project)))

;;; Run compile mode in a ghostel buffer
(use-package ghostel-compile
  :ensure nil
  :hook (after-init . ghostel-compile-global-mode))

;;; Run comint mode in a g hostel buffer
(use-package ghostel-comint
  :ensure nil
  :hook (after-init . ghostel-comint-global-mode))

;;; Neofetch.el (my package)
(use-package neofetch
  :vc (:url "https://codeberg.org/benja2998/neofetch.el"
 	    :branch "main"))

;;; Eshell syntax highlighting
(use-package eshell-syntax-highlighting
  :after eshell-mode
  :ensure t ;; Install if not already installed.
  :config
  ;; Enable in all Eshell buffers.
  (eshell-syntax-highlighting-global-mode +1))
(eshell-syntax-highlighting-global-mode t)

;;; Ido Mode emulation
(fido-mode t)

;;; Colorize colors
(use-package colorful-mode
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

;;; Eshell prompt
(use-package eshell-prompt-extras)
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-multiline-with-status "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-multiline-with-status))

;;; Destroy eshell visual buffers after process dies
(setq eshell-destroy-buffer-when-process-dies t)

;;; Open eshell quickly
(bind-key* "C-c e" 'ees/eshell-new)

;;; Always open urls in Librewolf
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "flatpak"
      browse-url-generic-args '("run" "io.gitlab.librewolf-community"))


;;; Exec path from shell: get environment variables from shell
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

;;; Org agenda configuration
(setq org-directory "~/Documents/Notes/")
(setq org-agenda-files (list org-directory))

;;; Theme
(load-theme 'my-awesome t)

;;; Ignore case in completion
(setq eshell-cmpl-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; Eshell visual commands configuration
(require 'ghostel-eshell)
(add-hook 'eshell-mode-hook (lambda ()
			      (add-to-list 'eshell-visual-commands "tinydash")
			      (add-to-list 'eshell-visual-commands "fzf")
			      (add-to-list 'eshell-visual-commands "pipes.sh")
			      (add-to-list 'eshell-visual-commands "cpipes")
			      (add-to-list 'eshell-visual-commands "cmatrix")
			      (add-to-list 'eshell-visual-commands "nvtop")
			      (add-to-list 'eshell-visual-commands "wiremix")
			      (cond ((eq system-type 'gnu/linux)
				     (st-eshell-visual-command-mode))
				    ((eq system-type 'android)
				     (ghostel-eshell-visual-command-mode)))))

(add-hook 'eshell-banner-load-hook (lambda ()
				     (setq eshell-banner-message
					   (concat (shell-command-to-string "fortune | cowsay") "\n\n"))))

;;; Pass message to mail client when sending with C-x m
(setq send-mail-function 'mailclient-send-it)

;;; Follow symlinks to version controlled files
(setq vc-follow-symlinks t)

;;; Visual line mode
(global-visual-line-mode t)

;;; Make org headings pretty
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.05)))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
