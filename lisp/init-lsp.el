(use-package lsp-mode
  :ensure t
  :defer 2
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (auctex . lsp)
	 (go-mode . lsp)
	 (c-mode . lsp)
	 (lisp-mode .lsp)
	 (emacs-lisp-mode .lsp)
	 (js2-mode .lsp)
	 (web-mode . lsp)
	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))
					; :commands lsp
					; :hook ('prog-mode . 'lsp-mode)
  :config
  (setq lsp-keymap-prefix "C-,")
  (use-package lsp-ui
    :ensure t
    :defer 2
    ;; :hook
    ;; ((lsp . lsp-ui-sideline-mode-hook)
    ;; (lsp . lsp-ui-doc-mode-hook)
    ;; (lsp . lsp-ui-imenu-mode-hook)
    ;; (lsp . lsp-ui-peek-mode-hook)
    ;; )
    :config
    (setq lsp-ui-doc-mode nil)
    :custom
    (lsp-ui-doc-delay 3)
    ;; (lsp-ui-doc-mode 0)
    )
  )

(use-package dap-mode
  :ensure t
  :defer 2
  :config
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  (require 'dap-go)
  )


;; (use-package nox 
;;   :defer 2
;;   :load-path "~/.emacs.d/site-lisp/nox"
;;   :config 
;;   (dolist (hook (list
;; 		 'js-mode-hook
;; 		 'rust-mode-hook
;; 		 'python-mode-hook
;; 		 'ruby-mode-hook
;; 		 'java-mode-hook
;; 		 'sh-mode-hook
;; 		 'php-mode-hook
;; 		 'c-mode-common-hook
;; 		 'go-mode-hook
;; 		 'c-mode-hook
;; 		 'c++-mode-hook
;; 		 'haskell-mode-hook
;; 		 'lisp-mode-hook
;; 		 ))
;;     (add-hook hook '(lambda () (nox-ensure))))
;;   )


(provide 'init-lsp)
