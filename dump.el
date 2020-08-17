(setq vainjoker-dumped t)
(require 'package)
;; load autoload files and populate load-path’s
(package-initialize)
;; store load-path
(setq vainjoker-dumped-load-path load-path)
;; (package-initialize) doens’t require each package, we need to load
;; those we want manually
(dolist (package '(
                   use-package
                   ;; doom-themes
                   kaolin-themes
                   doom-modeline
                   which-key
                   ;; benchmark-init
                   counsel
                   swiper
		   amx
		   flx
                   avy
		   ivy-posframe
		   ivy-rich
                   general
                   posframe
                   undo-tree
                   nlinum
                   nlinum-relative
                   rainbow-mode
                   ;; rainbow-delimiters
                   smartparens
                   ;; neotree
                   all-the-icons
                   ;; projectile
                   ivy-posframe
		   ;; eyebrowse
                   yasnippet
                   recentf
                   dashboard
		   ;; counsel-projectile
		   ;; wucuo
                   ;; org
                   ; pdf-tools
                   ; windmove
                   ; go-mode
                   ;; perspective
                   ;; google-translate
                   ;; telega
                   ;; youdao-dictionary
                   ;; bongo
                   ;; projectile
                   ;; ox
                   ;; org-pomodoro
                   ;; company
                   ;; company-lsp
                   ;; company-tabnine
                   ;; yasnippet-snippets
                   ; lsp-mode
                   ; lsp-ui
                   ; flycheck
                   ))
  (require package))
;; dump image
(dump-emacs-portable "/home/vainjoker/.emacs.d/emacs.pdmp")
