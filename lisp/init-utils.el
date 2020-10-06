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


(use-package helpful
  :defines (counsel-describe-function-function
            counsel-describe-variable-function)
  :commands helpful--buffer
  :bind (([remap describe-key] . helpful-key)
         ([remap describe-symbol] . helpful-symbol)
         ("C-c C-d" . helpful-at-point)
         :map helpful-mode-map
         ("r" . remove-hook-at-point))
  :hook (helpful-mode . cursor-sensor-mode) ; for remove-advice button
  :init
  (with-eval-after-load 'counsel
    (setq counsel-describe-function-function #'helpful-callable
          counsel-describe-variable-function #'helpful-variable))

  (with-eval-after-load 'apropos
    ;; patch apropos buttons to call helpful instead of help
    (dolist (fun-bt '(apropos-function apropos-macro apropos-command))
      (button-type-put
       fun-bt 'action
       (lambda (button)
         (helpful-callable (button-get button 'apropos-symbol)))))
    (dolist (var-bt '(apropos-variable apropos-user-option))
      (button-type-put
       var-bt 'action
       (lambda (button)
         (helpful-variable (button-get button 'apropos-symbol))))))

  ;; Add remove buttons for advices
  (define-advice helpful-update (:after () advice-remove-button)
    (when helpful--callable-p
      (add-button-to-remove-advice (helpful--buffer helpful--sym t) helpful--sym)))
  :config
  (with-no-warnings
    ;; Open the buffer in other window
    (defun my-helpful--navigate (button)
      "Navigate to the path this BUTTON represents."
      (find-file-other-window (substring-no-properties (button-get button 'path)))
      ;; We use `get-text-property' to work around an Emacs 25 bug:
      ;; http://git.savannah.gnu.org/cgit/emacs.git/commit/?id=f7c4bad17d83297ee9a1b57552b1944020f23aea
      (-when-let (pos (get-text-property button 'position
                                         (marker-buffer button)))
        (helpful--goto-char-widen pos)))
    (advice-add #'helpful--navigate :override #'my-helpful--navigate)))

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
