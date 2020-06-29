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
                   doom-themes
                   doom-modeline
                   which-key
                   ace-window
                   swiper
                   counsel
                   avy
                   ;; org
                   general
                   posframe
                   undo-tree
                   nlinum
                   nlinum-relative
                   rainbow-mode
                   rainbow-delimiters
                   smartparens
                   ; pdf-tools
                   ; windmove
                   ; go-mode
                   neotree
                   all-the-icons
                   projectile
                   ivy-posframe
                   perspective
                   ; google-translate
                   ; telega
                   ; youdao-dictionary
                   ; bongo
                   ; projectile
                   ; recentf
                   ;; dashboard
                   ;; benchmark-init
                   ;; ox
                   ;; org-pomodoro
                   ;; company
                   ;; company-lsp
                   ;; company-tabnine
                   ;; yasnippet
                   ;; yasnippet-snippets
                   ; lsp-mode
                   ; lsp-ui
                   ; flycheck
                   ))
  (require package))


;; dump image
(dump-emacs-portable "/home/vainjoker/.emacs.d/emacs.pdmp")
