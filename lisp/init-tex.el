(use-package auctex
  :ensure t
  :mode
  ("\\.tex'\\'" . auctex)
  :config
  (setq TeX-engine 'xetex)
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX")
  (use-package cdlatex
    :ensure t
    :defer 5
    )
  )

(provide 'init-tex)

