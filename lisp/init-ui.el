(use-package all-the-icons
  :if (display-graphic-p)
  )
(use-package doom-themes
  ;; :init (load-theme 'doom-one t)
  ;; :config
  ;; (load-theme 'doom-wilmersdorf t)
  ;; (load-theme 'doom-vibrant t)
  ;; (load-theme 'doom-gruvbox t)
  ;; (doom-themes-treemacs-config)
  )
(use-package kaolin-themes
  :init (load-theme 'kaolin-aurora t)
  (kaolin-treemacs-theme)
  ;; (load-theme 'kaolin-aurora t)
  )

(use-package doom-modeline
  :hook (window-setup . doom-modeline-mode)
  :config
  (use-package nyan-mode
    :hook (doom-modeline-mode . nyan-mode)
    :config
    (nyan-mode 1)
    (setq nyan-animate-nyancat t)
    (setq nyan-wavy-trail t)
    ;; (setq mode-line-format
    ;;   (list
    ;;    '(:eval (list (nyan-create)))
    ;;    ))
    )
  ; (setq display-battery-mode t)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-height 40)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-buffer-encoding nil)
  )
(use-package posframe)



(provide 'init-ui)
