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
    "bg" 'bongo
    "ca" 'counsel-ag
    "cf" 'counsel-fzf
    "cc" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "ci" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    "dd" 'dap-debug
    "da" 'dap-breakpoint-add
    "dx" 'dap-breakpoint-delete
    "dc" 'dap-breakpoint-delete-all
    "ee" 'eaf-open
    "eb" 'eaf-open-browser
    "eh" 'eaf-open-browser-with-history
    "em" 'eaf-open-mindmap
    "et" 'eaf-open-terminal
    "lu" 'lsp-ui-menu
    "oa" 'org-agenda
    "oc" 'org-capture
    "oo" 'VainJoker/open-gtd-file
    "oe" 'org-export-dispatch
    "op" 'org-pomodoro'
    "ou" 'org-priority-up
    "od" 'org-priority-down
    "oy" 'org-store-link
    "oi" 'org-insert-link
    "po" 'pomidor
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
    "mz" 'load-theme
    "mf" 'flycheck-mode
    "mt" 'vterm-toggle
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
    ;; "T" 'random-color-theme
    )

  (my-leader-def
    :keymaps 'visual
    "cc" 'evilnc-comment-or-uncomment-lines
    "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
    "ci" 'evilnc-copy-and-comment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs
    "cr" 'comment-or-uncomment-region
    "cv" 'evilnc-toggle-invert-comment-line-by-line
    )

  ;; ** Mode Keybindings
  ;; (my-local-leader-def
  ;;   :states 'normal
  ;;   :keymaps 'org-mode-map
  ;;   "y" 'org-store-link
  ;;   "p" 'org-insert-link
  ;;   )
  ;; * Settings
  ;; change evil's search module after evil has been loaded (`setq' will not work)
  (general-setq evil-search-module 'evil-search)
  )


(provide 'init-keybinds)
