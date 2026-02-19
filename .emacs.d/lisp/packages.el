(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

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

(provide 'packages)
