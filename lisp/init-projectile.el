;;; init-projectile.el --- Use Projectile for navigation within projects -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure t
  :defer 2
  :config
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1)
  )
; (when (maybe-require-package 'projectile)
;   (add-hook 'after-init-hook 'projectile-mode)
;
;   ;; Shorter modeline
;   (setq-default projectile-mode-line-prefix " Proj")
;
;   (after-load 'projectile
;     (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
;
;   (maybe-require-package 'ibuffer-projectile))


(provide 'init-projectile)
;;; init-projectile.el ends here
