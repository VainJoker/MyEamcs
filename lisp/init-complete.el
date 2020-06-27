(use-package company 
  :hook (after-init . global-company-mode) 
  :defer 2
  :config
  (setq company-tooltip-align-annotations t
	company-idle-delay 0 company-echo-delay 0
        company-minimum-prefix-length 2
	company-require-match nil
	company-dabbrev-ignore-case nil
	company-dabbrev-downcase nil
	company-show-numbers t
	)
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous))
  )

(use-package company-lsp
  :defer 2
  :ensure t
  :config
  (push 'company-lsp company-backends)
  )


(use-package company-tabnine
  :defer 2
  :ensure t
  :after 'company-mode 'company-tabnine-mode
  :config
  (add-to-list 'company-backends #'company-tabnine))

(use-package lsp-mode
  :defer 2
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp)
         (auctex . lsp)
         (c-mode . lsp)
	 (js2-mode .lsp)
	 (web-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  ; :commands lsp
  ; :hook ('prog-mode . 'lsp-mode)
  )


(provide 'init-complete)
