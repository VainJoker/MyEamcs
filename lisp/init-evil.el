(use-package evil
  :defer 0.5
  :init (evil-mode t)
  :config
  (with-eval-after-load 'evil-maps
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-normal-state-map (kbd "C-n") nil)
    (define-key evil-normal-state-map (kbd "C-p") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  )

(use-package evil-nerd-commenter
  :after evil
  :demand t
  )


(use-package evil-escape
  :after evil
  :demand t
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-key-sequence "nn")
  (setq-default evil-escape-delay 0.2)
  )


(provide 'init-evil)
