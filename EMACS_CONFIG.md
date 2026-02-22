
# Table of Contents

1.  [Emacs Config](#org2ad14c8)
    1.  [Options](#orgc11fddc)
    2.  [IDO mode](#orgf4c096e)
    3.  [Colors](#org833f857)
    4.  [Packages](#orgecf1954)
    5.  [Keys](#orga2111e4)
    6.  [Font](#org9ad07ee)
    7.  [LSP](#org97723dc)
    8.  [Modeline](#orgb17555f)
    9.  [Word wrap](#org2634e42)
    10. [Hooks](#orgf03c448)


<a id="org2ad14c8"></a>

# Emacs Config


<a id="orgc11fddc"></a>

## Options

The custom file should not exist. The closest thing to making it never be created is this.

    (setq custom-file (make-temp-file "emacs-custom"))

On macOS, both option keys are meta. On my keyboard layout, you need right option to type special characters, so I fix this like this.

    (setq mac-option-modifier 'meta)
    (setq mac-right-option-modifier 'none)

Typing 'yes' every time is annoying. Luckily, the fix is easy.

    (setq use-short-answers t)

Relative line numbers allow faster navigation, so i am enabling them.

    (global-display-line-numbers-mode +1)
    (menu-bar--display-line-numbers-mode-relative)

I want a clean UI.

    (menu-bar-mode 0)
    (scroll-bar-mode 0)
    (tool-bar-mode 0)

Now I need to make emacs less annoying.

    (setq inhibit-splash-screen t)
    (setq make-backup-files nil)
    (setq auto-save-default nil)
    (setq create-lockfiles nil)
    (setq tramp-auto-save-directory "/tmp")


<a id="orgf4c096e"></a>

## IDO mode

IDO mode is so universally useful. I do not get why this isn't enabled by defautl.

    (ido-mode t)
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)


<a id="org833f857"></a>

## Colors

modus-vivendi is a nice readable theme.

    (load-theme 'modus-vivendi t)


<a id="orgecf1954"></a>

## Packages

I need to set up the package manager.

    (require 'package)
    
    (setq package-archives
          '(("gnu"   . "https://elpa.gnu.org/packages/")
            ("melpa" . "https://melpa.org/packages/")
            ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
    
    (package-initialize)
    
    (require 'use-package)
    (setq use-package-always-ensure t)

To get the best Emacs experience, I use the packages Magit, some language modes, Vterm, Spaceline and Org superstar.

    (use-package magit
      :bind ("C-c g" . magit-status))
    
    (use-package markdown-mode
      :mode (("\\.md\\'" . markdown-mode)
             ("\\.markdown\\'" . markdown-mode))
      :init
      (setq markdown-command "pandoc"))
    
    (use-package typescript-mode
      :mode "\\.ts\\'")
    
    (use-package lua-mode
      :mode "\\.lua\\'")
    
    (use-package fish-mode
      :mode "\\.fish\\'")
    
    (use-package rust-mode
      :mode "\\.rs\\'")
    
    (use-package org-superstar
      :hook (org-mode . org-superstar-mode))
    
    (use-package vterm
      :ensure t)
    
    (use-package spaceline
      :ensure t)


<a id="orga2111e4"></a>

## Keys

Keys for faster and more precise window navigation with Windmove.

    (global-set-key (kbd "M-j") #'windmove-left)
    (global-set-key (kbd "M-l") #'windmove-right)
    (global-set-key (kbd "M-i") #'windmove-up)
    (global-set-key (kbd "M-k") #'windmove-down)

I want to open Vterm quickly.

    (global-set-key (kbd "C-c t") 'vterm)

Unset some keys I often accidentally hit.

    (global-unset-key (kbd "C-x C-b"))
    (global-unset-key (kbd "C-x C-d"))


<a id="org9ad07ee"></a>

## Font

I need to be able to read my code.

    (set-face-attribute 'default nil :height 140)


<a id="org97723dc"></a>

## LSP

I want my editor to be smart.

I need to require Eglot, which is the client built into emacs and is extremely easy to set up.

    (require 'eglot)

Now I need to configure each LSP I need.

    (add-hook 'typescript-mode-hook #'eglot-ensure)
    (add-hook 'js-mode-hook #'eglot-ensure)
    (add-hook 'c-mode-hook #'eglot-ensure)
    (add-hook 'c++-mode-hook #'eglot-ensure)
    (add-hook 'rust-mode-hook #'eglot-ensure)


<a id="orgb17555f"></a>

## Modeline

Make the modeline look pretty using Spaceline.

    (require 'spaceline-config)
    (spaceline-spacemacs-theme)


<a id="org2634e42"></a>

## Word wrap

Some Neovim web dev is probably going to find me and kill me for this.

    (global-visual-line-mode t)


<a id="orgf03c448"></a>

## Hooks

I set emacsclient as my default Git editor. I wanted to get Magit commit UI in the buffer, and the method I found was to load it on start like this.

    (add-hook 'emacs-startup-hook 'magit-status)
    (add-hook 'emacs-startup-hook 'magit-mode-bury-buffer t)

