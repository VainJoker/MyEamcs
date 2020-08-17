(use-package evil
  :ensure t
  :defer 0.5
  :config 
  (evil-mode t)
  (with-eval-after-load 'evil-maps
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-normal-state-map (kbd "C-n") nil)
    (define-key evil-normal-state-map (kbd "C-p") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
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
