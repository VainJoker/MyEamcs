;;设置主题
;; (load-theme 'doom-city-lights t)
;; (load-theme 'doom-one t)
; (load-theme 'doom-wilmersdorf t)
;; (load-theme 'doom-darcula t)
;; 设置透明
;; (set-frame-parameter nil 'alpha '(85 .100))
;; 设置英文字体
(set-face-attribute 'default nil :font "Iosevka 14")
;; 设置中文字体
;; (set-fontset-font t 'han "Sarasa Mono SC 13")

(use-package doom-themes 
 :ensure t
 :init (load-theme 'doom-wilmersdorf t)
 )

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 12)
  )

(use-package posframe
  :defer 1
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :config
  (progn
    (defun @-enable-rainbow ()
      (rainbow-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow)
))

(use-package rainbow-delimiters
  :ensure t
  :config
  (progn
    (defun @-enable-rainbow-delimiters ()
      (rainbow-delimiters-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters))
  )


;; (use-package dashboard
;;   :ensure t
;;   :config (dashboard-setup-startup-hook)
;;   (dashboard-modify-heading-icons '((recents . "file-text")
;;                     (bookmarks . "book")))
;;   ;; 设置标题
;;   (setq dashboard-banner-logo-title "Vain Joker")
;;   ;; 设置banner
;;   (setq dashboard-startup-banner "/home/vainjoker/.emacs.d/var/banner/a.png")
;;   (setq dashboard-items '(
;;               ; (recents  . 0)
;;               (projects . 0)
;;               (agenda . 0)
;;               (bookmarks . 0)
;;               ))
;;   (setq dashboard-center-content t)
;;   (setq dashboard-set-heading-icons t)
;;   (setq dashboard-set-file-icons t)
;;   (setq dashboard-set-navigator t)
;;   )



;; 为上层提供 init-ui 模块
(provide 'init-ui)
