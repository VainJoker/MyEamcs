(setq user-full-name "VainJoker"
      user-mail-address "vainjoker@163.com")

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
(add-to-list 'load-path "~/.emacs.d/var/themes")

(require 'init-ui)
(require 'init-tools)
(require 'init-evil)
(require 'init-basic)
(require 'init-git)
(require 'init-lsp)
(require 'init-company)
(require 'init-prog)
(require 'init-projectile)
(require 'init-org)
(require 'init-tex)
(require 'init-markdown)
(require 'init-go)
(require 'init-c)
(require 'init-python)
(require 'init-web)
(require 'init-ivy)
(require 'init-filemanager)
(require 'init-eaf)
(require 'init-keybinds)
(require 'init-mail)
;; (require 'init-java)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit-blame youdao-dictionary yasnippet-snippets which-key web-mode wanderlust vue-mode vterm use-package try treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil smartparens smart-input-source scss-mode rime rainbow-mode rainbow-delimiters python-environment python-black ox-reveal ox-pandoc org2ctex org-superstar org-roam org-pomodoro ob-go nyan-mode nlinum-relative neotree multiple-cursors lsp-ui lsp-python-ms lsp-pyright lsp-java kaolin-themes js2-mode ivy-rich ivy-posframe isolate indent-guide hungry-delete graphviz-dot-mode google-translate go-mode general flycheck-posframe flycheck-pos-tip flycheck-popup-tip flx eyebrowse exwm evil-nerd-commenter evil-escape epc emmet-mode editorconfig doom-themes doom-modeline deft dashboard dap-mode counsel-projectile counsel-etags company-web company-tabnine company-posframe company-lsp company-ctags company-box cdlatex ccls cal-china-x benchmark-init auctex amx ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "red"))))
 '(flycheck-posframe-border-face ((t (:inherit default)))))
