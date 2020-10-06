;; (use-package cnfonts
;;   :init (cnfonts-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cnfonts-set-spacemacs-fallback-fonts)
  ;; )

(use-package english-teacher
  :demand t
  :defer 2
  :load-path "~/.emacs.d/site-lisp/english-teacher" ;; NOTE: here type english teacher directory
  :hook ((Info-mode
          elfeed-show-mode
          eww-mode
          Man-mode
          Woman-Mode) . english-teacher-follow-mode)
  :custom
  (english-teacher-backend 'baidu)
  (english-teacher-show-result-function 'english-teacher-eldoc-show-result-function)
  )


(use-package sis
  :after evil
  :hook
  (((text-mode prog-mode) . sis-follow-context-mode)
   ((text-mode prog-mode) . sis-inline-mode))
  :config
  (sis-ism-lazyman-config "1" "2" 'fcitx5)
  (sis-global-inline-mode)
  (sis-global-respect-mode)
  (sis-global-cursor-color-mode)
  (sis-global-follow-context-mode)
  )

(provide 'init-language)
