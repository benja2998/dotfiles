(setq vc-follow-symlinks t)

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook
  (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

(let ((org-file "~/.emacs.d/config.org")
      (el-file "~/.emacs.d/config.el")
      (elc-file "~/.emacs.d/config.elc"))
  (when (or (not (file-exists-p elc-file))
            (file-newer-than-file-p org-file elc-file))
    (require 'org)
    (org-babel-tangle-file org-file el-file "elisp")
    (byte-compile-file el-file))
  (load-file elc-file))
