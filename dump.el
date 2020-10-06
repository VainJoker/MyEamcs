(setq vainjoker-dumped t)
(require 'package)
;; load autoload files and populate load-path’s
(package-initialize)
;; store load-path
(setq vainjoker-dumped-load-path load-path)
(dolist (package '(
                   benchmark-init
                   kaolin-themes
                ;;doom-themes
                   all-the-icons
                   doom-modeline
                   display-line-numbers
                   hl-line
                   centaur-tabs
                   which-key
                   dashboard
                   diminish
                   bind-key
                   dired
                   treemacs
                   company
                   company-box
                   company-quickhelp
                   company-prescient
                   posframe
                   yasnippet
                   counsel
                   ivy
                   ivy-posframe
                   ivy-rich
                   swiper
                   avy
                   smartparens
                   flycheck
                   flyspell
                   imenu
                   general
                   projectile
                   recentf
                   savehist
                   hungry-delete
                   font-lock
                   ace-window
                   ediff
                   expand-region
                   help
                   helpful
                   undo-tree
                   winner
                   bookmark
                   anzu
                   drag-stuff
                   eldoc
                   so-long
                   nyan-mode
                   rainbow-mode
                   rainbow-delimiters
                   tooltip
                   ))
  (require package)
  )

;; dump image
(dump-emacs-portable "/home/vainjoker/.emacs.d/emacs.pdmp")
