;; -*- lexical-binding: t; -*-

;;; For future customizations
(require 'eshell)

;;; Local packages
(add-to-list 'load-path (concat user-emacs-directory "local/"))

;;; Neofetch
(ignore-error t (require 'neofetch))

(defun daily-note ()
  "Open today's daily note"
  (interactive)
  (setq current-date-file (concat "~/Documents/Notes/" (format-time-string "%Y" (current-time)) "/" (format-time-string "%d-%m-%Y" (current-time)) ".org"))
  (setq current-date (format-time-string "%d-%m-%Y" (current-time)))
  (find-file current-date-file)
  (unless (file-exists-p current-date-file)
    (insert (concat "* " current-date (format "\n"))))
  )

(defun todo-note ()
  "Open todo.org note"
  (interactive)
  (find-file "~/Documents/Notes/todo.org")
  )

(defun dired-videos ()
  "Open videos directory"
  (interactive)
  (dired "~/Videos")
  )

(defun dired-music ()
  "Open music directory"
  (interactive)
  (dired "~/Music")
  )

;;; Smooth scrolling with mouse or trackpad
(pixel-scroll-precision-mode t)

;;; Scroll conservatively
(setq scroll-conservatively 101)

;;; Bind-key is the modern way to bind keys
(require 'bind-key)

;;; Keybinds
(bind-key* "C-c nt" 'daily-note)
(bind-key* "C-c tn" 'todo-note)
(bind-key* "C-c ne" 'org-agenda-list)
(bind-key* "C-c ny" 'dired-videos)
(bind-key* "C-c nm" 'dired-music)
(bind-key* "C-x M-c M-b u t t e r f l y" 'butterfly)

;;; Window navigation
(bind-key* "C-M-h" 'windmove-left)
(bind-key* "C-M-j" 'windmove-down)
(bind-key* "C-M-k" 'windmove-up)
(bind-key* "C-M-l" 'windmove-right)

;;; Better than using Meta + Arrows
(with-eval-after-load 'org
  (bind-key "M-l" #'org-do-demote 'org-mode-map)
  (bind-key "M-h" #'org-do-promote 'org-mode-map))

(defun eshell-clear ()
  "Clear interactively eshell"
  (interactive)
  (execute-kbd-macro (kbd "cls RET"))
  )

;;; Fix for eshell-mode-map not working immediately
(defun bind-eshell-clear-mode-map ()
  (interactive)
  (bind-key "C-l" #'eshell-clear 'eshell-mode-map)
  )
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
  (dired "~/Documents/Notes")
  )

(defun dired-home ()
  "Open home directory"
  (interactive)
  (dired "~")
  )

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
       (add-to-list 'default-frame-alist '(font . "Terminess Nerd Font:pixelsize=24")))
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
  (eshell-vterm-exec-visual "wiremix"))

(defun run-nmtui ()
  (interactive)
  (eshell-vterm-exec-visual "nmtui"))

(defun run-boomer ()
  (interactive)
  (start-process-shell-command
   "boomer" nil "/home/benjamin/Thirdparty/boomer/boomer"))

(defun run-htop ()
  (interactive)
  (eshell-vterm-exec-visual "htop"))

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

(use-package vterm
  :ensure t)

(use-package eshell-vterm
  :ensure nil
  :load-path "local/eshell-vterm"
  :demand t
  :after eshell
  :config
  (eshell-vterm-mode))

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

(setq eshell-destroy-buffer-when-process-dies t)
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook (lambda ()
			   (setq word-wrap t)
			   (setq truncate-lines nil)
			   (setq truncate-partial-width-windows nil)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "921f165deb8030167d44eaa82e85fcef0254b212439b550a9b6c924f281b5695"
     "088cd6f894494ac3d4ff67b794467c2aa1e3713453805b93a8bcb2d72a0d1b53"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "22a0d47fe2e6159e2f15449fcb90bbf2fe1940b185ff143995cc604ead1ea171"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "42a6583a45e0f413e3197907aa5acca3293ef33b4d3b388f54fa44435a494739"
     "e8bd9bbf6506afca133125b0be48b1f033b1c8647c628652ab7a2fe065c10ef0"
     "7de64ff2bb2f94d7679a7e9019e23c3bf1a6a04ba54341c36e7cf2d2e56e2bcc"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "70c88c01b0b5fde9ecf3bb23d542acba45bb4c5ae0c1330b965def2b6ce6fac3"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
     "c4df9006b9eb32599d758800a32f3487c2cdf13826084511783b47d419024af2"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a"
     "5f5770ecd10cb9a93f2df4bd05a5d6102892941cf2795eaffa4ed24d78e5a6f6"
     "5e1741398293d0df87244a34ad47241e10f57b06e07cd62ad44089ab95d85e01"
     "f44bb32804c6dc06f539c82ff978f7178eef577caa90c0b89260fa4e67ba3322"
     "97883740d8f11ce7c1470ed8270afc15f45e6dac244af9b6ffd19c930ea7b224"
     "3601d00861446211cfd3831d2ccef176ceb7de11d24e6ee1d725ec6b7000d51a"
     "90c390c234a3c5d92ac5e3589893e03e963a11a16db448b1bae243e988efadec"
     "4db745f7ba0382641879fa0d22bf7fd0d508e3097325e588aeaa999930a69c96"
     "4106992a80cd7577fe00e245efb8bb1b1634eebc83ac6eb433aad94d4fe3b277"
     "190cc1fa948c584b5249c4cb9d291741b411725a9de4217e35dceacfb01b83af"
     "ec62fb807e829715a4d1f5f203caf0269c70636503a56090ab1c0ea6ba6e3d93"
     "65577618e9064f96f8e693a1b3186b9501beead85de864cf700eb2b49ed337c7"
     "bf0553e3a3b19f00fb188d1f43fc9f36b1d841338bfa5d43b31fdb02061ecff0"
     "2780e94926161e072b6e4e45ee0ea9619076d8c05c581dce52ac32d5b1db1fea"
     "2a564a42029d98a8d2ceaeea6df5621db48085c474bc03761f4c258ae34af06c"
     "e1937c2748656b49cb6636a0c1a999f58e4acde3d24fa583ee7ecc38fc656c6c"
     "eb404ef3a5ec124e7312dc37476c49b2e588d3b060b67ba222e51e6662f648cf"
     "ffa253294a6a68181986e9b4110d7176deaf007198b6677d5a9fecb2401ac951"
     "820f02e02cddf808f79de2749bff5c3c570529249ebb76767988a1ca7d923cd7"
     "5b598ea012ecbc5641643c8bda01ca4e3662582a432a66a27822b78f402945ca"
     default))
 '(eshell-cmpl-ignore-case t)
 '(eshell-mode-hook
   '(#[nil
       ((if (member "tinydash" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "tinydash" eshell-visual-commands)))
	(if (member "fzf" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "fzf" eshell-visual-commands)))
	(if (member "codex" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "codex" eshell-visual-commands)))
	(if (member "cmatrix" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "cmatrix" eshell-visual-commands)))
	(if (member "nvtop" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "nvtop" eshell-visual-commands)))
	(if (member "wiremix" eshell-visual-commands)
	    eshell-visual-commands
	  (setq eshell-visual-commands
		(cons "wiremix" eshell-visual-commands)))
	(eshell/export
	 (concat "GPG_TTY="
		 (shell-command-to-string "/bin/sh tty 2>/dev/null"))))
       (t)]))
 '(eshell-visual-subcommands '(("git" "log" "diff" "show")))
 '(org-agenda-files '("~/Documents/Notes/"))
 '(package-selected-packages nil)
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(safe-local-variable-values
   '((eval and buffer-file-name
	   (not (eq major-mode 'package-recipe-mode))
	   (or (require 'package-recipe-mode nil t)
	       (let ((load-path (cons "../package-build" load-path)))
		 (require 'package-recipe-mode nil t)))
	   (package-recipe-mode))))
 '(send-mail-function 'mailclient-send-it)
 '(truncate-lines nil)
 '(vc-follow-symlinks t)
 '(word-wrap t))
(put 'upcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
