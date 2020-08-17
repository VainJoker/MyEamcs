;; 设置透明
;; (set-frame-parameter nil 'alpha '(85 .100))
;; 设置英文字体
(set-face-attribute 'default nil :font "Iosevka 14")
;; 设置中文字体
;; (set-fontset-font t 'han "Sarasa Mono SC 13")

(use-package doom-themes
  :ensure t
  :config
  ;; (load-theme 'doom-wilmersdorf t)
  ;; (load-theme 'doom-vibrant t)
  ;; (load-theme 'doom-gruvbox t)
  ;; (doom-themes-treemacs-config)
  )
(use-package kaolin-themes
  :ensure t
  :config
  (kaolin-treemacs-theme)
  (treemacs-icons-dired-mode)
  ;; (load-theme 'kaolin-aurora t)
  (load-theme 'kaolin-galaxy t)
  )

(setq color-themes (custom-available-themes))
(defun random-color-theme ()
  (interactive)
  (random t)
  (load-theme
   (nth (random (length color-themes)) color-themes)
   t))
;; (random-color-theme)
;; (run-with-timer 1 (* 120 60) 'random-color-theme)


(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t
  )

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (use-package nyan-mode
    :after doom-modeline
    :ensure t
    :config
    (nyan-mode 1)
    (setq nyan-animate-nyancat t)
    (setq nyan-bar-length 90)
    (setq nyan-wavy-trail nil)
    (setq mode-line-format
	  (list
	   '(:eval (list (nyan-create)))
	   ))
    )
  (setq doom-modeline--battery-status t)
  (setq doom-modeline-height 40)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-modal-icon nil)
  (setq doom-modeline--battery-status t)
  )

(use-package posframe
  :defer 1
  :ensure t
  )

(use-package rainbow-mode
  :ensure t
  :defer 1
  :config
  (progn
    (defun @-enable-rainbow ()
      (rainbow-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow)
    ))

(use-package rainbow-delimiters
  :ensure t
  :defer 1
  :config
  (progn
    (defun @-enable-rainbow-delimiters ()
      (rainbow-delimiters-mode t))
    (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters))
  )

(use-package dashboard 
  :ensure t 
  :config (dashboard-setup-startup-hook) 
  (dashboard-modify-heading-icons '((recents . "file-text") 
                                    (bookmarks . "book")))
  ;; 设置标题
  (setq dashboard-banner-logo-title
        "Hello Vain Joker!")
  ;; 设置banner
  (setq dashboard-startup-banner "~/.emacs.d/var/banner/a.png") 
  (setq dashboard-center-content t) 
  (setq dashboard-set-heading-icons t) 
  (setq dashboard-set-file-icons t) 
  (setq dashboard-set-navigator t)
  (setq dashboard-items '(
              (recents  . 5)
              (projects . 5)
              ))
  )

;; (use-package circadian
;;   :ensure t
;;   :defer 5
;;   :config
;;   ;; 经纬度，可以在https://www.latlong.net/获取，默认是广州的
;;   (setq calendar-latitude 31.530280
;; 	calendar-longitude 120.288879
;; 	;; sunrise 白天用的主题 sunset 晚上用的主题
;; 	circadian-themes '((:sunrise . doom-solarized-light)
;; 			   (:sunset . doom-one))
;; 	)
;;   (circadian-setup)
;;   )

;; 为上层提供 init-ui 模块
(provide 'init-ui)
