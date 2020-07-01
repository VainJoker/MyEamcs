(use-package nlinum
  :ensure t
  :config
  (global-nlinum-mode)
  )
  

(use-package nlinum-relative
  :ensure t
  :config
  (global-nlinum-relative-mode)
  )
  
;; (use-package perspective
;;   :ensure t
;;   :config
;;   (persp-mode 1)
;;   )
(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode 1))

(use-package hideshow 
  :defer 2
  :ensure t 
  :diminish hs-minor-mode 
  :hook (prog-mode . hs-minor-mode))
  
;; (use-package wucuo
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'wucuo-start)
;;   (add-hook 'text-mode-hook #'wucuo-start)
;;   )
  

(use-package eaf
  :defer 2
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (eaf-setq eaf-browser-dark-mode "true")
  (eaf-setq eaf-mindmap-dark-mode "true")
  (eaf-setq eaf-pdf-dark-mode "true")
  (eaf-setq eaf-browser-default-zoom "1.25")
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (setq eaf-proxy-type "socks5")
  (setq eaf-proxy-host "127.0.0.1")
  (setq eaf-proxy-port "1080"))
  

(use-package deft
  :ensure t
  :defer 2
  :config
  (setq deft-extensions '("txt" "md" "tex" "org"))
  (setq deft-directory "~/Notes")
  (setq deft-text-mode 'org-mode)
  (setq deft-use-filename-as-title t)
  (setq deft-incremental-search nil)
  (setq deft-recursive t))
  

(use-package neotree
  :ensure t
  :after evil
  :bind ("<f2>" . neotree-toggle)
  :config
  (evil-set-initial-state 'neotree-mode 'normal)
  (evil-define-key 'normal neotree-mode-map
    (kbd "RET") 'neotree-enter
    (kbd "c")   'neotree-create-node
    (kbd "r")   'neotree-rename-node
    (kbd "d")   'neotree-delete-node
    (kbd "j")   'neotree-next-node
    (kbd "k")   'neotree-previous-node
    (kbd "g")   'neotree-refresh
    (kbd "C")   'neotree-change-root
    (kbd "I")   'neotree-hidden-file-toggle
    (kbd "H")   'neotree-hidden-file-toggle
    (kbd "q")   'neotree-hide
    (kbd "l")   'neotree-enter))
    

;; (use-package parinfer
;;   :ensure t
;;   :bind
;;   ("C-," . parinfer-toggle-mode)
;;   :init
;;   (progn
;;     (setq parinfer-extensions
;;           '(defaults       ; should be included.
;;             pretty-parens  ; different paren styles for different modes.
;;             evil           ; If you use Evil.
;;             lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
;;             paredit        ; Introduce some paredit commands.
;;             smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
;;             smart-yank))
    
;;     ;; Yank behavior depend on mode.
;;     ;; (add-hook 'clojure-mode-hook #'parinfer-mode)
;;     ;; (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
;;     ;; (add-hook 'common-lisp-mode-hook #'parinfer-mode)
;;     ;; (add-hook 'scheme-mode-hook #'parinfer-mode)
;;     ;; (add-hook 'lisp-mode-hook #'parinfer-mode))
;;     (add-hook 'prog-mode-hook #'parinfer-mode)))
  

(use-package smartparens
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t))
    
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode))
  ;; (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)


;; (use-package recentf
;;  :defer 2
;;  :config
;;  (recentf-mode 0)
;;  ; (setq recentf-max-menu-item 5)
;;  )

(use-package desktop
  :defer 2
  :ensure t
  :config
  (desktop-save-mode 1)
  (desktop-auto-save-enable))
  

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

(use-package vterm
  :defer 2
  :ensure t)
  

(use-package youdao-dictionary
  :defer 2
  :ensure t
  :config
  (setq url-automatic-caching t))
  

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
   

(use-package pdf-tools
  :defer 3
  :ensure t
  :hook
  ('doc-view-mode 'pdf-view-mode-hook))

(use-package windmove
  :defer 3
  :ensure t
  :init (windmove-default-keybindings)
  :config)
  


(use-package try
  :defer 5
  :ensure t)
  

;; 谷歌翻译
(use-package google-translate
  :defer 3
  :ensure t
  :config
  (setq google-translate--tkk-url "http://translate.google.cn/")
  google-translate-base-url "http://translate.google.cn/translate\_a/single"
  google-translate-listen-url "https://translate.google.cn/translate\_tts"
  google-translate-default-target-language "zh-CN"
  google-translate-default-source-language "en")

;; (use-package benchmark-init
;;   :ensure t
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))

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
  

(use-package company-graphviz-dot
  :defer 3
  :after graphviz-dot-mode)
  


(provide 'init-tools)


