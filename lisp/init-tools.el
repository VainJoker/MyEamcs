(use-package nlinum
  :ensure t
  :disabled t
  :config
  (add-hook 'prog-mode-hook 'nlinum-mode-hook)
  )
;; (use-package nlinum-relative
;;   :ensure t
;;   :config
;;   (nlinum-relative-setup-evil)                    ;; setup for evil
;;   (add-hook 'prog-mode-hook 'nlinum-relative-mode)
;;   (setq nlinum-relative-redisplay-delay 0.25)      ;; delay
;;   (setq nlinum-relative-current-symbol "▷")      ;; or "" for display current line number
;;   (setq nlinum-relative-offset 0)                 ;; 1 if you want 0, 2, 3...
;;   )

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package indent-guide
  :after prog-mode
  :ensure t
  :hook (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-delay 0.1)
  (setq indent-guide-recursive t)
  )

(use-package sis
  :ensure t
  :after evil 
  :config
  (sis-ism-lazyman-config "1" "2" 'fcitx5)
  (sis-global-inline-mode)
  (sis-global-respect-mode)
  (sis-global-cursor-color-mode)
  (sis-global-follow-context-mode)
  )


(use-package multiple-cursors
  :ensure t 
  :defer 4
  )
;; (use-package eyebrowse
;;   :ensure t
;;   :defer 3
;;   :config
;;   (eyebrowse-mode 1))
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
  :ensure t
  :defer 3
  :config
  (progn
    (show-smartparens-global-mode t))
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
  (with-eval-after-load 'smartparens
    (dolist (brace '("(" "{" "["))
      (sp-pair brace nil
	       :post-handlers '(("||\n[i]" "RET")
				("| " "SPC"))
	       :unless '(sp-point-before-word-p sp-point-before-same-p))))
  )

(use-package isolate
  :ensure t 
  :defer 3
  )

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
;; (use-package english-teacher
;;   :load-path "english-teacher-path" ;; NOTE: here type english teacher directory
;;   :hook ((Info-mode
;;           elfeed-show-mode
;;           eww-mode
;;           Man-mode
;;           Woman-Mode) . english-teacher-follow-mode)
;;   )
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

(use-package benchmark-init
  :ensure t
  :defer 5
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  )

(provide 'init-tools)


