(use-package evil
             :init (evil-mode t)
             :config 
             (with-eval-after-load 'evil-maps
                                   (define-key evil-insert-state-map (kbd "C-n") nil)
                                   (define-key evil-normal-state-map (kbd "C-n") nil)
                                   (define-key evil-normal-state-map (kbd "C-p") nil)
                                   (define-key evil-insert-state-map (kbd "C-p") nil))
             )

(use-package evil-nerd-commenter
             :defer 2
             :after evil
             )


(use-package evil-escape
             :after evil
             :defer 2
             :config
             (evil-escape-mode 1)
             (setq-default evil-escape-key-sequence "nn")
             (setq-default evil-escape-delay 0.2)
             )


(provide 'init-evil)
