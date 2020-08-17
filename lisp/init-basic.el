(setq split-width-threshold 0)
(setq split-height-threshold nil)
;; 设置最近打开文件缓存的路径
(setq recentf-save-file "~/.emacs.d/var/recentf")
;; 设置书签文件路径
(setq bookmark-default-file "~/.emacs.d/var/bookmarks")
;; 设置自动保存路径
(setq auto-save-list-file-prefix "~/.emacs.d/var/auto-save-list/.saves-")
;; 设置amx保存文件的路径
(setq amx-save-file "~/.emacs.d/var/amx-items")
;; 设置eshell历史记录
(setq eshell-history-file-name "~/.emacs.d/var/eshell/history")
;; 高亮括号
(show-paren-mode 1)
;; 自动折行
(toggle-truncate-lines t)
;; 设置背景透明
(set-frame-parameter nil 'alpha 0.8)
;; 窗口重绘
(setq auto-window-vscroll nil)
(use-package which-key
  :ensure t
  :custom
  (which-key-popup-type 'side-window)
  :config
  (which-key-mode))

(use-package ace-window
  :defer 2
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "red")))))))

(use-package swiper
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   ;; ("C-c C-r" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package counsel
  :ensure t
  :bind
  (("C-x C-r" . 'counsel-recentf)
   ("C-x d" . 'counsel-dired)))

(use-package avy
  :ensure t
  :bind (("M-g :" . 'avy-goto-char)
         ("M-g '" . 'avy-goto-char-2)
         ("M-g \"" . 'avy-goto-char-timer)
         ("M-g f" . 'avy-goto-line)
         ("M-g w" . 'avy-goto-word-1)
         ("M-g e" . 'avy-goto-word-0)))

(use-package hungry-delete
  :defer 2
  :ensure t
  :hook ('prog-mode . 'global-hungry-delete-mode)
  )


(use-package rime
  :defer 2
  :ensure t
  :config
  (setq rime-user-data-dir "~/.config/fcitx/rime")
  (setq default-input-method "rime"
        rime-show-candidate 'posframe)
  (setq rime-posframe-properties
	(list :background-color "#333333"
              :foreground-color "#dcdccc"
              :font "WenQuanYi Micro Hei Mono-14"
              :internal-border-width 10))
  (setq rime-disable-predicates
      '(rime-predicate-evil-mode-p
        rime-predicate-after-alphabet-char-p
        rime-predicate-prog-in-code-p))
  :bind
  ("M-n" . 'rime-force-enable)
  )


(use-package helpful
 :defer 2
 :config
 (global-set-key (kbd "C-h f") #'helpful-callable)
 (global-set-key (kbd "C-h v") #'helpful-variable)
 (global-set-key (kbd "C-h k") #'helpful-key)
 (global-set-key (kbd "C-c C-d") #'helpful-at-point)
 (global-set-key (kbd "C-h F") #'helpful-function)
 (global-set-key (kbd "C-h C") #'helpful-command)
)


(provide 'init-basic)
