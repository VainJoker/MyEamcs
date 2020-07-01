(setq user-full-name "VainJoker"
      user-mail-address "vainjoker@163.com")

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(defvar vainjoker-dumped nil
  "non-nil when a dump file is loaded (because dump.el sets this variable).")

(defmacro vainjoker-if-dump (then &rest else)
  "Evaluate IF if running with a dump file, else evaluate ELSE."
  (declare (indent 1))
  `(if vainjoker-dumped
     ,then
     ,@else))

(defun vainjoker-dump ()
  "Dump Emacs."
  (interactive)
  (let ((buf "*dump process*"))
    (make-process
      :name "dump"
      :buffer buf
      :command (list "emacs" "--batch" "-q"
                     "-l" (expand-file-name "dump.el"
                                            user-emacs-directory)))
    (display-buffer buf)))

(vainjoker-if-dump
  (progn
    (setq load-path vainjoker-dumped-load-path)
    (global-font-lock-mode)
    (transient-mark-mode)
    (add-hook 'after-init-hook
              (lambda ()
                (save-excursion
                  (switch-to-buffer "*scratch*")
                  (lisp-interaction-mode)))))
  ;; add load-path’s and load autoload files
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(require 'init-ui)
(require 'init-tools)
(require 'init-evil)
(require 'init-basic)
(require 'init-git)
(require 'init-complete)
(require 'init-prog)
(require 'init-projectile)
(require 'init-org)
(require 'init-tex)
(require 'init-markdown)
(require 'init-go)
(require 'init-python)
(require 'init-web)
(require 'init-keybinds)
(require 'init-ivy)

;; (defmacro k-time (&rest body)
;;   "Measure and return the time it takes evaluating BODY."
;;   `(let ((time (current-time)))
;;      ,@body
;;      (float-time (time-since time))))
;; (defvar k-gc-timer
;;   (run-with-idle-timer 15 t
;;                        'garbage-collect))
;; (setq read-process-output-max (* 1024 1024 128))
;; (setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/") load-path))
;; (setq gc-cons-threshold (* 2 1000 1000))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" default))
 '(package-selected-packages
   '(wucuo parinfer eyebrowse deft yasnippet-snippets yasnippet go-mode doom-themes use-package rainbow-mode rainbow-delimiters posframe doom-modeline))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "red"))))
 '(flycheck-posframe-border-face ((t (:inherit default)))))
