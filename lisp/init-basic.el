;; Personal information
(setq user-full-name "VainJoker"
      user-mail-address "vainjoker@163.com")

;; linenumber
(use-package display-line-numbers
  :ensure nil
  :hook
  (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative)
  (defun buffer-too-big-p ()
    (or (> (buffer-size) (* 5000 80))
        (> (line-number-at-pos (point-max)) 5000)))
  (add-hook 'prog-mode-hook
            (lambda ()
              (if (buffer-too-big-p) (display-line-numbers-mode -1))))
  )

;; History
(use-package saveplace
             :ensure nil
             :hook (after-init . save-place-mode))

(use-package recentf
             :ensure nil
             :bind (("C-x C-r" . recentf-open-files))
             :hook (after-init . recentf-mode)
             :init (setq recentf-max-saved-items 300
                         recentf-exclude
                         '("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
                           "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
                           "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
                           "^/tmp/" "^/var/folders/.+$" ; "^/ssh:"
                           (lambda (file) (file-in-directory-p file package-user-dir))))
             :config (push (expand-file-name recentf-save-file) recentf-exclude))

(use-package savehist
             :ensure nil
             :hook (after-init . savehist-mode)
             :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
                         history-length 1000
                         savehist-additional-variables '(mark-ring
                                                          global-mark-ring
                                                          search-ring
                                                          regexp-search-ring
                                                          extended-command-history)
                         savehist-autosave-interval 300))

;; (use-package simple
;;              :ensure nil
;;              :hook ((after-init . size-indication-mode)
;;                     (text-mode . visual-line-mode)
;;                     ((prog-mode markdown-mode conf-mode) . enable-trailing-whitespace))
;;              :init
;;              (setq column-number-mode t
;;                    line-number-mode t
;;                    ;; kill-whole-line t               ; Kill line including '\n'
;;                    line-move-visual nil
;;                    track-eol t                     ; Keep cursor at end of lines. Require line-move-visual is nil.
;;                    set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again

;;              ;; Visualize TAB, (HARD) SPACE, NEWLINE
;;              (setq-default show-trailing-whitespace nil) ; Don't show trailing whitespace by default
;;              (defun enable-trailing-whitespace ()
;;                "Show trailing spaces and delete on saving."
;;                (setq show-trailing-whitespace t)
;;                (add-hook 'before-save-hook #'delete-trailing-whitespace nil t)))

(use-package time
             :ensure nil
             :unless (display-graphic-p)
             :hook (after-init . display-time-mode)
             :init (setq display-time-24hr-format t
                         display-time-day-and-date t))

(use-package so-long
             :ensure nil
             :hook (after-init . global-so-long-mode)
             :config (setq so-long-threshold 400))

;; Mouse & Smooth Scroll
;; Scroll one line at a time (less "jumpy" than defaults)
(when (display-graphic-p)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
        mouse-wheel-progressive-speed nil))
(setq scroll-step 1
      scroll-margin 0
      scroll-conservatively 100000)
;;(setq auto-window-vscroll nil)

(setq-default major-mode 'text-mode
              fill-column 80
              tab-width 4
              indent-tabs-mode nil)     ; Permanently indent with spaces, never with TABs
(setq visible-bell t
      inhibit-compacting-font-caches t  ; Don’t compact font caches during GC.
      delete-by-moving-to-trash t       ; Deleting files go to OS's trash folder
      make-backup-files nil             ; Forbide to make backup files
      auto-save-default nil             ; Disable auto save
      uniquify-buffer-name-style 'post-forward-angle-brackets ; Show path if names are same
      adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
      adaptive-fill-first-line-regexp "^* *$"
      sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil)

(show-paren-mode 1)
(set-frame-parameter nil 'alpha 0.8)
(provide 'init-basic)
