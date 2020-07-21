(use-package ccls
  :ensure t
  :defer 5
  :config
  (setq ccls-executable "/usr/local/bin/ccls")
  :hook ((c-mode c++-mode objc-mode) . (lambda () (require 'ccls) (lsp)))
  :custom
  (ccls-executable (executable-find "ccls"))
  (ccls-sem-highlight-method 'font-lock)
  (ccls-enable-skipped-ranges nil)
  )
(provide 'init-c)
