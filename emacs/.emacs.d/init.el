(setq vc-follow-symlinks t)

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
  (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

(let ((org-file "~/.emacs.d/config.org")
      (el-file "~/.emacs.d/config.el"))
  (when (or (not (file-exists-p el-file))
	    (file-newer-than-file-p org-file el-file))
    (require 'org)
    (org-babel-tangle-file org-file el-file "elisp"))
    (load-file el-file))
