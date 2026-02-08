(require 'eglot) ; Eglot is now built into emacs

(add-hook 'typescript-mode-hook #'eglot-ensure)
(add-hook 'js-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'rust-mode-hook #'eglot-ensure)
(provide 'lsp)
