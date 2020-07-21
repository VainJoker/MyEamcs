;; (use-package nlinum
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook 'nlinum-mode-hook)
;;   )
(use-package nlinum-relative
  :ensure t
  :config
  (nlinum-relative-setup-evil)                    ;; setup for evil
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0.25)      ;; delay
  (setq nlinum-relative-current-symbol "▷")      ;; or "" for display current line number
  (setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...
  )

(use-package indent-guide
  :after prog-mode
  :ensure t
  :hook (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-delay 0.1)
  (setq indent-guide-recursive t)
  )

(use-package multiple-cursors
  :ensure t 
  :defer 4
  )
(use-package eyebrowse
  :ensure t
  :defer 3
  :config
  (eyebrowse-mode 1))
(use-package hideshow 
  :defer 2
  :ensure t 
  :diminish hs-minor-mode 
  :hook (prog-mode . hs-minor-mode))
(use-package ag
  :ensure t
  :defer 3
  :custom
  (ag-highligh-search t)
  (ag-reuse-buffers t)
  (ag-reuse-window t)
  :bind
  ("M-s a" . ag-project)
  ) 
(use-package smartparens
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t))
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode))
(use-package recentf
  :ensure t
  :defer 3
  )
(use-package desktop
  :ensure t
  :defer 2
  :config
  (desktop-save-mode 1)
  (desktop-auto-save-enable)
  )
(use-package vterm
  :defer 3
  :ensure t)
(use-package youdao-dictionary
  :defer 2
  :ensure t
  :config
  (setq url-automatic-caching t))
(use-package windmove
  :defer 3
  :ensure t
  )
(use-package try
  :defer 5
  :ensure t)
(use-package google-translate
  :defer 3
  :ensure t
  :config
  (setq google-translate--tkk-url "http://translate.google.cn/")
  google-translate-base-url "http://translate.google.cn/translate\_a/single"
  google-translate-listen-url "https://translate.google.cn/translate\_tts"
  google-translate-default-target-language "zh-CN"
  google-translate-default-source-language "en")
(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))
(use-package graphviz-dot-mode
  :defer 2
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))
(use-package benchmark-init
  :ensure t
  :defer 5
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  )
;; (use-package wanderlust
;;   :ensure t
;;   :defer 5
;;   :init
;;   (if (boundp 'mail-user-agent)
;;       (setq mail-user-agent 'wl-user-agent))
;;   (if (fboundp 'define-mail-user-agent)
;;       (define-mail-user-agent
;; 	'wl-user-agent
;; 	'wl-user-agent-compose
;; 	'wl-draft-send
;; 	'wl-draft-kill
;; 	'mail-send-hook))
;;   :config
;;   (setq elmo-imap4-default-server "imap.163.com"
;;       elmo-imap4-default-user "vainjoker@163.com"
;;       elmo-imap4-default-authenticate-type 'clear
;;       elmo-imap4-default-port '993
;;       elmo-imap4-default-stream-type 'ssl)
;;   )
;; (use-package telega
;;   :ensure t
;;   :defer 2
;;   :init (setq telega-proxies)
;;         '((:server "localhost"))
;;        :port 1080
;;        :enable t
;;        :type (:@type "proxyTypeSocks5")
;;   (setq telega-chat-fill-column 65)
;;   (setq telega-emoji-use-images nil)
;;   :config
;;   (set-fontset-font t 'unicode (font-spec :family "Symbola") nil 'prepend)
;;   (with-eval-after-load 'company (add-hook 'telega-chat-mode-hook (lambda ()))
;;                     (make-local-variable
;;                      'company-backends)
;;                     (dolist (it)
;;                        '(telega-company-botcmd
;;                          telega-company-emoji)
;;                       (push it company-backends)))
;;   (with-eval-after-load 'all-the-icons (add-to-list 'all-the-icons-mode-icon-alist)
;;                 '(telega-root-mode all-the-icons-fileicon
;;                        "telegram"
;;                        :heigt 1.0
;;                        :v-adjust -0.2
;;                        :face all-the-icons-yellow)
;;       (add-to-list 'all-the-icons-mode-icon-alist '(telega-chat-mode)
;;                       all-the-icons-fileicon
;;                       "telegram"
;;                       :heigt 1.0
;;                       :v-adjust -0.2
;;                       :face all-the-icons-blue))
;;   (telega-notifications-mode 1)
;;   (telega-mode-line-mode 1))
;; (use-package bongo
;;   :ensure t
;;   :defer 2
;;   :config (defun bongo-init ())
;;       (interactive)
;;       (let ((buffer (current-buffer)))
;;         (bongo)
;;         (setq bongo-insert-whole-directory-trees "ask")
;;         (bongo-insert-file "~/Music")
;;         (bongo-insert-enqueue-region (point-min)
;;              (point-max))
;;         (bongo-play-random)
;;         (switch-to-buffer buffer)))



(provide 'init-tools)


