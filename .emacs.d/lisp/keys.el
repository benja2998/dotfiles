(global-set-key (kbd "M-h") #'windmove-left)
(global-set-key (kbd "M-l") #'windmove-right)
(global-set-key (kbd "M-k") #'windmove-up)
(global-set-key (kbd "M-j") #'windmove-down)
(global-set-key (kbd "C-c t") 'vterm)
(global-unset-key (kbd "C-x C-b")) ;; C-x b is a lot more useful
(global-unset-key (kbd "C-x C-d")) ;; C-x d is a lot more useful
(provide 'keys)
