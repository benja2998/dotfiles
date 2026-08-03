;; -*- lexical-binding: t; -*-

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

(setq eshell-destroy-buffer-when-process-dies t)
(when (daemonp) (exec-path-from-shell-initialize))
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

(add-hook 'org-mode-hook (lambda ()
			   (setq word-wrap t)
			   (setq truncate-lines nil)
			   (setq truncate-partial-width-windows nil)))

(setq org-directory "~/Documents/Notes/")
(setq org-agenda-files (list org-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(my-awesome))
 '(custom-safe-themes
   '("27e8e6fb52af47873987c01b354a92f263503809bd6b1194efe56febfabe4c1d"
     "70c76a1bf0c17b046702b7c1f1aa88f9eff2d87fa6e6a9f4ad6867abdd0c8bff"
     "6a0ba5873af19027cfcc412c32d57be5c294688f03513690490bb67e642b5ad9"
     "0cbc8b3aa9a6943cd827af21800e76e7f68d15fb8eacfebb7fea116a8b92c84e"
     "8ee5b9738238bb0f1ce4bf44c68b2f5ad3ec882aa685660c221fdb86295b9ab9"
     "5c93585acf49359214683112a6e0041b9e5a0d4685b438c2f355365e9272a608"
     "e328d3997194801d0acc774719292c95d4f0d7ea08c012eef4d132ed610d5f63"
     "51c37ecb855d4406c6f54e34318bc44f49d391783d776f8fa1fd90f087efcba6"
     "c303f4e7b6db88594b5e49c52dc219deba3b3dd37d64dec37ec6cc6e48b21a74"
     "56c2c378f2fe325f24a6ecb489031b87f92db11594c30934c13290cdca507b4f"
     "7c52d9282d76464307a1ac97e088712c6a77dbd6838d0f16a5b5a25a0e55cb30"
     "5115d93551ce8a20e4001adfd634b99ef82c2b640bec5f9005044bb27f8c8ed1"
     "93ff405064f8eaaf14b80a8383b7a87792b6fb418618c62a0ababf916f37147b"
     "8c56c73d68243c2e1904a670ec65330a8236defa09a5e6eced0fff2025436d8c"
     "9b3403c6d09266ca657435332540e0d1773b5afc7b52e0ab3a299d8b999e4504"
     "b800c09fcc5ce7c2118fe8b0e84e0036b1b8bc55c94ec7e6edc3478fa25b001e"
     "ed826e444dc1b8ecba80717ffbdeb409b5f0b00fd36d8f9cbb235daef5bd8f84"
     "d987ace513225e2491cf802fafe1fbfc451879e72574d1f7b40096e2899a7612"
     "9e15309919fa41172aea4b7eabf4ffa1adeb6a268c0908d642ae8f5eebb4252f"
     "74b6b50f439b7130e82c23c465107edbfd2ea05fe78ab89bf76d4c9282bc8a3c"
     "1474a963df8ad6666dd0be87a88ea8094a895170393f9d90c8002c2c8507c903"
     "4255aa6ff06dbb0c38882e3404ac39a18115138329eb69cf51633e6c86895a2e"
     "e58bb0cbe01bd18a133d95f338467f53cc2a64a9b1a1d9ba0f8d216c25df4a81"
     "a202afe8067ad0eaca4a4bfcff7f37a58ad108f003fc745ca56b84870db0043f"
     "1e9d61401dc55d78df4ef4f24970b362a229d681bfb60ad8f318590d0eb9f5ef"
     "07236961880bc97796bbb9a0dedc7f208188702e4f5df414c6c9906e5187d756"
     "511b9b4a2e5ecffd0691a464da391f6596925200ed9f3d419d8845d72905beda"
     "587fcbc2ed0c74149f24c1c32a959d4604ecdf54622a703228f500902709b803"
     "e2ed032eaf79a2946db46371a5ddc75968b00315935c6327b7c77b04ec0a9abb"
     "d480d152107e0c061f713f439c7571674c97afd9a1883355bcf7c15bce1213e7"
     "f493c29a38b415943bb357f4e0da0ca4793d9fa7d8a00d36c9717af180e80f0c"
     "3e058e6926e138ea927c0a64d5f24fd056c2ee2a7fc90d8e4614f17ae556349f"
     "0da1aa562b5a112f2377e69fdbd00313f7e7a3122a4a0738a17bf82a4a3a2cf9"
     "ad8b96bee2e6dd4b4733e80555580ee37d3a104a2f40e83a429ef6d32a406eb5"
     "be3b6ee0f7117283df2bc2f900ba2f92b3e98fd6cac4e587607ad912e0c9e982"
     "b8607c9c84d771211bc248433dfcdf2fc413c37b0be3358545ade71bd890b137"
     "7fcc44486414d1b9d6082e662c00335926c6a6d6b56d6e398498e627b86cd1a3"
     "090409e456f7708394675b09df5f5c661f901c01c1bd6ef8f6d74c45aa45a3e3"
     "58cb07897e09679305bdff946085d7accbb22e1434eb2663bc56262e4f2b8513"
     "b64c915c8993f207baf5910ae28633b2e148771601a6e29445968ed13a9b179a"
     "10e330880269244ae45ae9e02fe6f55766da9e15036e7c7f07d7ce228195deb5"
     "e79df8c0d4b0ee48c22acfa4c4750664adf47ab13bed897e8c80460d624b0927"
     "7f7b4e498f83fab146365b2dd9fa48fe7314ceb6cfd59f21a5a5b0395257ea62"
     "c374e13901216c0c67acd628c852cec9faf9adc01784364e1908be8d598214a6"
     "6dcc66a60dce37a5817d46e7b1f838ac5d95a79061119adeb7c04c7ae9f511d0"
     "967c23e9ba179b80560774419f081df22e7674aac23c5c550b817e4a1ce7d058"
     "2493d0ad0bb94bd2ad297a6d76288751a532fd6d8d6af694ac14008caa6b7fa2"
     "138ed99a323c1b93c52f4b3726caf2bc634b79a76fa63a3d3aff76394db5f28f"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
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
	(ghostel-eshell-visual-command-mode)
	(eshell/export
	 (concat "GPG_TTY="
		 (shell-command-to-string "/bin/sh tty 2>/dev/null"))))
       (t)]))
 '(eshell-visual-subcommands '(("git" "log" "diff" "show")))
 '(org-agenda-files '("~/Documents/Notes/"))
 '(org-directory "~/Documents/Notes")
 '(package-selected-packages
   '(colorful-mode dmenu eshell-prompt-extras exec-path-from-shell exwm
		   ghostel lua-mode markdown-mode
		   modus-themes-exporter multiple-cursors neofetch
		   orderless org-superstar package-lint rust-mode))
 '(package-vc-selected-packages
   '((neofetch :url "https://codeberg.org/benja2998/neofetch.el" :branch
	       "main")
     (modus-themes-exporter :vc-backend Git :url
			    "https://github.com/protesilaos/modus-themes-exporter.git")))
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
 '(org-level-1 ((t (:inherit outline-1 :height 1.25))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.15))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.05)))))
