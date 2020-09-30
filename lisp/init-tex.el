(use-package auctex
  :mode
  ("\\.tex'\\'" . auctex)
  :config
  (setq TeX-engine 'xetex)
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX")
  (use-package cdlatex
    :hook(auctex . cdlatex-mode)
    )
  )

(provide 'init-tex)
