 ;; 设置英文字体
(set-face-attribute 'default nil :font "Iosevka 14")

; ;; 设置中文字体
; ;; (set-fontset-font t 'han "Sarasa Mono SC 13")
;

(use-package all-the-icons
             :if (display-graphic-p)
             )
(use-package doom-themes
 ;; :init (load-theme 'doom-one t)
             ; :config
             ;; (load-theme 'doom-wilmersdorf t)
             ;; (load-theme 'doom-vibrant t)
             ;; (load-theme 'doom-gruvbox t)
             ;; (doom-themes-treemacs-config)
             )
(use-package kaolin-themes
             :init (load-theme 'kaolin-aurora t)
             (kaolin-treemacs-theme)
             (treemacs-icons-dired-mode)
             ;; (load-theme 'kaolin-aurora t)
             )
(use-package doom-modeline
    :hook (window-setup . doom-modeline-mode)
             :config
             (use-package nyan-mode
               :after doom-modeline
               :init
               (nyan-mode 1)
               :config
               (setq nyan-animate-nyancat t)
               (setq nyan-wavy-trail nil)
               ; (setq mode-line-format
               ;   (list
               ;    '(:eval (list (nyan-create)))
               ;    ))
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
;

(use-package posframe)
;
; (use-package rainbow-mode
;   :ensure t
;   :defer 1
;   :config
;   (progn
;     (defun @-enable-rainbow ()
;       (rainbow-mode t))
;     (add-hook 'prog-mode-hook '@-enable-rainbow)
;     ))
;
; (use-package rainbow-delimiters
;   :ensure t
;   :defer 1
;   :config
;   (progn
;     (defun @-enable-rainbow-delimiters ()
;       (rainbow-delimiters-mode t))
;     (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters))
;   )


; (setq color-themes (custom-available-themes))
; (defun random-color-theme ()
;   (interactive)
;   (random t)
;   (load-theme
;    (nth (random (length color-themes)) color-themes)
;    t))
;; (random-color-theme)
;; (run-with-timer 1 (* 120 60) 'random-color-theme)


;; 为上层提供 init-ui 模块
(provide 'init-ui)
