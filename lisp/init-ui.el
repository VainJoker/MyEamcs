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
  :hook
  (window-setup . doom-modeline-mode)
  :config
  (use-package nyan-mode
    :hook (doom-modeline-mode . nyan-mode)
    :config
    (nyan-mode 1)
    (setq nyan-animate-nyancat t)
    (setq nyan-wavy-trail t)
    (setq mode-line-format
          (list
           '(:eval (list (nyan-create)))
           ))
    )
  (display-time-mode t)
  (display-battery-mode t)
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

(use-package posframe
  )

(use-package centaur-tabs
  :demand t
  :after evil
  :config
  (setq centaur-tabs-style "wave"
        centaur-tabs-height 22
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-close-button ""
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t)
  (centaur-tabs-headline-match)
  ;; (setq centaur-tabs-gray-out-icons 'buffer)
  ;; (centaur-tabs-enable-buffer-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (vterm . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups)
  (:map evil-normal-state-map
   ("g t" . centaur-tabs-forward)
   ("g T" . centaur-tabs-backward)))

(provide 'init-ui)
