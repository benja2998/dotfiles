;; Set the custom file
(setq custom-file (make-temp-file "emacs-custom"))

;; Add the lisp directory to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Require the files
(require 'options)
(require 'navigation)
(require 'lsp)
(require 'packages)
(require 'keys)
(require 'theme)
(require 'font)
