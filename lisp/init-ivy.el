;; 美化ivy(swiper和counsel)
(use-package 
  all-the-icons-ivy-rich 
  :defer 2
  :ensure t 
  :init (all-the-icons-ivy-rich-mode 1)) 
(use-package 
  ivy-posframe 
  :ensure t 
  :init (ivy-posframe-mode 1) 
  :custom (ivy-posframe-parameters '((left-fringe . 8) 
				     (right-fringe . 8))) 
  (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center))))
;; counsel提供对项目管理的支持
(use-package 
  counsel-projectile 
  :defer 3
  :ensure t 
  :hook ((counsel-mode . counsel-projectile-mode)) 
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)) 
)

(provide 'init-ivy)
