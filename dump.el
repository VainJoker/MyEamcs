(setq vainjoker-dumped t)
(require 'package)
;; load autoload files and populate load-path’s
(package-initialize)
;; store load-path
(setq vainjoker-dumped-load-path load-path)
(dolist (package '(
                   kaolin-themes
                ;;doom-themes
                   all-the-icons
                   doom-modeline
                   which-key
                   dashboard
                   dired
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
                   fancy-narrow
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
                   undo-tree
                   winner
                   ))
  (require package)
  )

;; dump image
(dump-emacs-portable "/home/vainjoker/.emacs.d/emacs.pdmp")
