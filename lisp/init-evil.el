(use-package evil
  :ensure t
  :defer 0.5
  :config 
  (evil-mode t)
  )

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  )


(use-package evil-escape
  :after evil
  :ensure t
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-key-sequence "nn")
  (setq-default evil-escape-delay 0.2)
  ;; (global-set-key (kbd "C-c C-g") 'evil-escape)
  )


(provide 'init-evil)
