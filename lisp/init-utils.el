(use-package which-key
  :diminish
  :hook (after-init . which-key-mode)
  :bind ("C-h M-m" . which-key-show-major-mode)
  :init (setq which-key-max-description-length 30
              which-key-show-remaining-keys t)
  :config
  (which-key-add-key-based-replacements "C-c !" "flycheck")
  (which-key-add-key-based-replacements "C-c &" "yasnippet")
  (which-key-add-key-based-replacements "C-c c" "counsel")
  (which-key-add-key-based-replacements "C-c n" "org-roam")
  (which-key-add-key-based-replacements "C-c t" "hl-todo")
  (which-key-add-key-based-replacements "C-c v" "ivy-view")
  (which-key-add-key-based-replacements "C-c C-z" "browse")

  (which-key-add-key-based-replacements "C-x RET" "coding-system")
  (which-key-add-key-based-replacements "C-x 8" "unicode")
  (which-key-add-key-based-replacements "C-x @" "modifior")
  (which-key-add-key-based-replacements "C-x X" "edebug")
  (which-key-add-key-based-replacements "C-x a" "abbrev")
  (which-key-add-key-based-replacements "C-x n" "narrow")
  (which-key-add-key-based-replacements "C-x t" "tab")
  (which-key-add-key-based-replacements "C-x C-a" "edebug")
  )
;; (which-key-add-major-mode-key-based-replacements 'emacs-lisp-mode
;;                                                  "C-c ," "overseer")
;; (which-key-add-major-mode-key-based-replacements 'python-mode
;;                                                  "C-c C-t" "python-skeleton")
;; (which-key-add-major-mode-key-based-replacements 'markdown-mode
;;                                                  "C-c C-a" "markdown-link")
;; (which-key-add-major-mode-key-based-replacements 'markdown-mode
;;                                                  "C-c C-c" "markdown-command")
;; (which-key-add-major-mode-key-based-replacements 'markdown-mode
;;                                                  "C-c C-s" "markdown-style")
;; (which-key-add-major-mode-key-based-replacements 'markdown-mode
;;                                                  "C-c C-t" "markdown-header")
;; (which-key-add-major-mode-key-based-replacements 'markdown-mode
;;                                                  "C-c C-x" "markdown-toggle")
;; (which-key-add-major-mode-key-based-replacements 'gfm-mode
;;                                                  "C-c C-a" "markdown-link")
;; (which-key-add-major-mode-key-based-replacements 'gfm-mode
;;                                                  "C-c C-c" "markdown-command")
;; (which-key-add-major-mode-key-based-replacements 'gfm-mode
;;                                                  "C-c C-s" "markdown-style")
;; (which-key-add-major-mode-key-based-replacements 'gfm-mode
;;                                                  "C-c C-t" "markdown-header")
;; (which-key-add-major-mode-key-based-replacements 'gfm-mode
;;   "C-c C-x" "markdown-toggle")
;; Persistent the scratch buffer
(use-package persistent-scratch
  :diminish
  :bind (:map persistent-scratch-mode-map
         ([remap kill-buffer] . (lambda (&rest _)
                                  (interactive)
                                  (user-error "Scrach buffer cannot be killed")))
         ([remap revert-buffer] . persistent-scratch-restore)
         ([remap revert-this-buffer] . persistent-scratch-restore))
  :hook ((after-init . persistent-scratch-autosave-mode)
         (lisp-interaction-mode . persistent-scratch-mode)))

;; Search tools
;; Writable `grep' buffer
(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t
        wgrep-change-readonly-file t))

(use-package rg
  :defines projectile-command-map
  :hook (after-init . rg-enable-default-bindings)
  :bind (:map rg-global-map
         ("c" . rg-dwim-current-dir)
         ("f" . rg-dwim-current-file)
         ("m" . rg-menu)
         :map rg-mode-map
         ("m" . rg-menu))
  :init (setq rg-group-result t
              rg-show-columns t)
  :config
  (cl-pushnew '("tmpl" . "*.tmpl") rg-custom-type-aliases)

  (with-eval-after-load 'projectile
    (defalias 'projectile-ripgrep #'rg-project)
    (bind-key "s R" #'rg-project projectile-command-map))

  (with-eval-after-load 'counsel
    (bind-keys
     :map rg-global-map
     ("R" . counsel-rg)
     ("F" . counsel-fzf))))

;; Youdao Dictionary
(use-package youdao-dictionary
  :init
  (setq url-automatic-caching t
        youdao-dictionary-use-chinese-word-segmentation t) ; 中文分词
  )

;; A Simple and cool pomodoro timer
(use-package pomidor
  :init
  (setq alert-default-style 'mode-line)
  (with-eval-after-load 'all-the-icons
    (setq alert-severity-faces
          '((urgent   . all-the-icons-red)
            (high     . all-the-icons-orange)
            (moderate . all-the-icons-yellow)
            (normal   . all-the-icons-green)
            (low      . all-the-icons-blue)
            (trivial  . all-the-icons-purple))
          alert-severity-colors
          `((urgent   . ,(face-foreground 'all-the-icons-red))
            (high     . ,(face-foreground 'all-the-icons-orange))
            (moderate . ,(face-foreground 'all-the-icons-yellow))
            (normal   . ,(face-foreground 'all-the-icons-green))
            (low      . ,(face-foreground 'all-the-icons-blue))
            (trivial  . ,(face-foreground 'all-the-icons-purple))))))

;; Nice writing
(use-package olivetti
  :diminish
  :bind ("<f7>" . olivetti-mode)
  :hook
  (text-mode . olivetti-mode)
  (eww-mode . olivetti-mode)
  :init (setq olivetti-body-width 0.618)
  )

;; cntered curter
(use-package centered-cursor-mode
  :bind ("<f8>" . centered-cursor-mode)
  :hook (eww-mode . centered-cursor-mode)
  )

;; Music player
(use-package bongo
  :config
  (with-eval-after-load 'dired
    (with-no-warnings
      (defun bongo-add-dired-files ()
        "Add marked files to the Bongo library."
        (interactive)
        (bongo-buffer)
        (let (file (files nil))
          (dired-map-over-marks
           (setq file (dired-get-filename)
                 files (append files (list file)))
           nil t)
          (with-bongo-library-buffer
           (mapc 'bongo-insert-file files)))
        (bongo-switch-buffers))
      (bind-key "b" #'bongo-add-dired-files dired-mode-map))))

;; IRC
(use-package erc
  :ensure nil
  :defines erc-autojoin-channels-alist
  :init (setq erc-rename-buffers t
              erc-interpret-mirc-color t
              erc-lurker-hide-list '("JOIN" "PART" "QUIT")
              erc-autojoin-channels-alist '(("freenode.net" "#emacs"))))

;; A stackoverflow and its sisters' sites reader
(use-package howdoyou
  :bind (:map howdoyou-mode-map
         ("q" . kill-buffer-and-window))
  :hook (howdoyou-mode . read-only-mode))

(use-package hideshow
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode)
  )

(use-package smartparens
  :config
  (progn
    (show-smartparens-global-mode t))
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
  (with-eval-after-load 'smartparens
    (dolist (brace '("(" "{" "["))
      (sp-pair brace nil
               :post-handlers '(("||\n[i]" "RET")
                                ("| " "SPC"))
               :unless '(sp-point-before-word-p sp-point-before-same-p)))
    )
  )
                                        ;
                                        ; Misc
(use-package copyit)                    ; copy path, url, etc.
(use-package diffview)                  ; side-by-side diff view
(use-package focus)                     ; Focus on the current region
(use-package list-environment)
(use-package memory-usage)
(use-package tldr)

(provide 'init-utils)
