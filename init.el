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

(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       'garbage-collect))
(setq read-process-output-max (* 1024 1024 128))
(setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/") load-path))
(autoload 'nesc-mode "nesc.el")
(add-to-list 'auto-mode-alist '("\\.nc\\'" . nesc-mode))

(setq gc-cons-threshold (* 2 1000 1000))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes 'nil)
 '(eaf-find-alternate-file-in-dired t t)
 '(lsp-ui-doc-delay 1 t)
 '(org-roam-directory "~/org-roam" t)
 '(package-selected-packages
   '(cdlatex youdao-dictionary yasnippet-snippets which-key web-mode vue-mode vterm use-package try telega smartparens scss-mode rime rainbow-mode rainbow-delimiters quickrun projectile pdf-tools ox-reveal ox-pandoc org2ctex org-superstar org-pomodoro ob-go nlinum-relative neotree magit lsp-ui js2-mode hungry-delete graphviz-dot-mode google-translate go-mode general flycheck-posframe flycheck-pos-tip flycheck-popup-tip evil-nerd-commenter evil-escape evil esup emmet-mode doom-themes doom-modeline dashboard darcula-theme counsel company-web company-tabnine company-lsp company-auctex cal-china-x bongo benchmark-init ace-window))
 '(which-key-popup-type 'side-window))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "red"))))
 '(flycheck-posframe-border-face ((t (:inherit default)))))

