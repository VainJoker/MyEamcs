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
(add-to-list 'load-path "~/.emacs.d/themes")

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
;; (require 'init-java)
(require 'init-mail)

(setq user-mail-address "vainjoker@163.com"
      user-full-name "vainjoker")
(setq message-send-mail-function 'smtpmail-send-it
        smtpmail-default-smtp-server "smtp.163.com"
        smtpmail-smtp-server "smtp.163.com"
        smtpmail-smtp-service 465
        smtpmail-stream-type 'ssl
        smtpmail-local-domain "homepc")

;; (setq gnus-select-method
;;       '(nnimap "163.com"
;;                (nnimap-address "imap.163.com")
;;                (nnimap-inbox "INBOX")
;;                (nnimap-expunge t)
;;                (nnimap-server-port 993)
;;                (nnimap-stream ssl)))

;; (setq send-mail-function 'smtpmail-send-it
;;       smtpmail-smtp-server "smtp.163.com"
;;       smtpmail-smtp-service 994
;;       smtpmail-stream-type 'ssl
;;       gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'plain
;;       smtpmail-smtp-server "smtp.163.com"
;;       smtpmail-smtp-service 25
;;       smtpmail-smtp-user "vainjoker@163.com")
;; (setq auth-sources '((:source "~/.emacs.d/gnus/authinfo")))
;; (require 'gnus) ;; 设置自己的默认email地址，和用户名
;; (setq user-mail-address	"vainjoker@163.com"
;;       user-full-name	"vainjoker")

;; ;;设置获取邮件的服务区地址
;; (setq gnus-select-method '(nnimap "pop.163.com"))
;; ;;(add-to-list 'gnus-secondary-select-methods '(nnimap "imap.qq.com"))

;; ;;设置发送邮件的服务器地址
;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-smtp-server "pop.163.com")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(kaolin-galaxy))
 '(custom-safe-themes
   '("7e5d400035eea68343be6830f3de7b8ce5e75f7ac7b8337b5df492d023ee8483" default))
 '(fci-rule-color "#556873")
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(objed-cursor-color "#DF8C8C")
 '(package-selected-packages
   '(lsp-pyright jedi company-jedi lsp-python-ms python-black live-py-mode company-solidity solidity-flycheck solidity-mode editorconfig isolate org-latex-instant-preview cdlatex valign smart-input-source sis youdao-dictionary yasnippet-snippets which-key web-mode wanderlust vue-mode vterm use-package try treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil smartparens scss-mode rime rainbow-mode rainbow-delimiters ox-reveal ox-pandoc org2ctex org-superstar org-roam org-pomodoro ob-go nyan-mode nlinum-relative neotree multiple-cursors lsp-ui lsp-java kaolin-themes js2-mode ivy-rich ivy-posframe indent-guide hungry-delete graphviz-dot-mode google-translate go-mode general flycheck-posframe flycheck-pos-tip flycheck-popup-tip flx eyebrowse exwm evil-nerd-commenter evil-escape emmet-mode doom-themes doom-modeline deft dashboard dap-mode counsel-projectile counsel-etags company-web company-tabnine company-posframe company-lsp company-ctags company-box ccls cal-china-x benchmark-init auctex amx ag))
 '(pdf-view-midnight-colors (cons "#c5d4dd" "#3c4c55"))
 '(rustic-ansi-faces
   ["#3c4c55" "#DF8C8C" "#A8CE93" "#DADA93" "#83AFE5" "#D18EC2" "#7FC1CA" "#c5d4dd"])
 '(vc-annotate-background "#3c4c55")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A8CE93")
    (cons 40 "#b8d293")
    (cons 60 "#c9d693")
    (cons 80 "#DADA93")
    (cons 100 "#e2d291")
    (cons 120 "#eaca90")
    (cons 140 "#F2C38F")
    (cons 160 "#e7b1a0")
    (cons 180 "#dc9fb1")
    (cons 200 "#D18EC2")
    (cons 220 "#d58db0")
    (cons 240 "#da8c9e")
    (cons 260 "#DF8C8C")
    (cons 280 "#c98f92")
    (cons 300 "#b39399")
    (cons 320 "#9e979f")
    (cons 340 "#556873")
    (cons 360 "#556873")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "red"))))
 '(flycheck-posframe-border-face ((t (:inherit default)))))
