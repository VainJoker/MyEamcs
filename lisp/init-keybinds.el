(use-package general
  ;; :after evil
  :ensure t
  :config
  (general-evil-setup t)
  ;; (define-key evil-motion-state-map " " nil)
					;(general-define-key
					; :states 'motion
					; ";" 'evil-ex
					; ":" 'evil-repeat-find-char)
  (general-create-definer my-leader-def
    ;; :prefix my-leader
    :prefix "SPC")

  
  (general-create-definer my-local-leader-def
    ;; :prefix my-local-leader
    :prefix "SPC m")
  ;; ** Global Keybindings
  (my-leader-def
    :keymaps 'normal
    ;; bind "SPC a"
    "TAB" 'hs-toggle-hiding
    "."  'compile
    "ca" 'counsel-ag
    "cf" 'counsel-fzf
    "cc" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "ci" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    "dd" 'dap-debug
    "da"  'dap-breakpoint-add
    "dx"  'dap-breakpoint-delete
    "dc"  'dap-breakpoint-delete-all
    "oa" 'org-agenda
    "oc" 'org-capture
    "oo" 'VainJoker/open-gtd-file
    "oe" 'org-export-dispatch
    "op" 'org-pomodoro'
    "ou" 'org-priority-up
    "od" 'org-priority-down
    "vc" 'calendar
    "bb" 'switch-to-buffer
    "bk" 'kill-this-buffer
    "bm" 'counsel-bookmark
    "ff" 'find-file
    "wl" 'windmove-right
    "wh" 'windmove-left
    "wk" 'windmove-up
    "wj" 'windmove-down
    "wL" 'windmove-swap-states-down
    "wv" 'evil-window-vsplit
    "mc" 'calendar
    "mt" 'vterm-other-window
    "mz" 'load-theme
    "me" 'neotree-toggle
    "mf" 'flycheck-mode
    "ql" 'desktop-read
    "tt" 'youdao-dictionary-search-at-point-posframe
    "ti" 'youdao-dictionary-search-from-input
    "tv" 'youdao-dictionary-play-voice-at-point
    ;; "gb" 'magit-blame-mode 
    ;; "gl" 'magit-file-log
    ;; "gr" 'magit-grep
    "A" 'org-agenda
    "D" 'deft
    "G" 'magit-status
    "P" 'projectile-command-map
    )

 (general-define-key
  :keymaps '(normal visual)
  "cc" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ci" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "tt" 'youdao-dictionary-search-at-point-posframe
  "ti" 'youdao-dictionary-search-from-input
  "tv" 'youdao-dictionary-play-voice-at-point
  )



					; :bind (:map leader-key
					;             ("b RET" . 'bongo-dwim)
					;             ("b i" . 'bongo-init)
					;             ("b x" . 'bongo-kill-region)
					;             ("b d" . 'bongo-kill-line)
					;             ("b _" . 'bongo-undo)
					;             ("b SPC" . 'bongo-pause/resume)
					;             ("b TAB" . 'bongo-toggle-collapsed)
					;             ("b h" . 'bongo-seek-backward-10)
					;             ("b l" . 'bongo-seek-forward-10)
					;             ("b a" . 'bongo-insert-enqueue)
					;             ("b n" . 'bongo-play-next)
					;             ("b p" . 'bongo-play-previous)
					;             ("b r" . 'bongo-play-random)
					;             ("b s" . 'bongo-sprinkle)))
					;  :bind 
					;  (("C-x y t" . 'youdao-dictionary-search-at-point-tooltip)
					;   ("C-x y p" . 'youdao-dictionary-play-voice-at-point)
					;   ("C-x y r" . 'youdao-dictionary-search-and-replace)

					;   ("C-x y i" . 'youdao-dictionary-search-from-input)))
					;:bind (:map leader-key

  ;; ** Mode Keybindings
  (my-local-leader-def
    :states 'normal
    :keymaps 'org-mode-map
    "y" 'org-store-link
    "p" 'org-insert-link
    )
  ;; * Settings
  ;; change evil's search module after evil has been loaded (`setq' will not work)
  (general-setq evil-search-module 'evil-search)
  )

(provide 'init-keybinds)
