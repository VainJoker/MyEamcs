(use-package flycheck
  :defer 2
  :ensure t
  ;; :init (global-flycheck-mode 0)
  :config
  (which-key-add-key-based-replacements
    "M-SPC t t" "开关flycheck")
  ;; 美化一下
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center)

    ;; 用GUI tooltips来显示检查到的错误
    (use-package flycheck-posframe
      :after flycheck
      :defer 2
      :ensure t
      :custom-face (flycheck-posframe-border-face ((t (:inherit default))))
      :hook (flycheck-mode . flycheck-posframe-mode)
      :init (setq flycheck-posframe-border-width 1
		  flycheck-posframe-inhibit-functions
		  '((lambda (&rest _) (bound-and-true-p company-backend))))
      (use-package flycheck-pos-tip
	:after flycheck
	:defer 2
	:ensure t
	:defines flycheck-pos-tip-timeout
	:hook (global-flycheck-mode . flycheck-pos-tip-mode)
	:config (setq flycheck-pos-tip-timeout 30)))
    (use-package flycheck-popup-tip
      :after flycheck
      :ensure t
      :hook (flycheck-mode . flycheck-popup-tip-mode))
    )
  )

(use-package yasnippet
  :defer 5
  :after company
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'text-mode-hook #'yas-minor-mode)
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"                 ;; personal snippets
	  ))
  (use-package yasnippet-snippets
    :defer t
    :ensure t
    )
  )

;; (setq solidity-solc-path "/bin/solc")
;; (use-package solidity-mode
;;   :ensure t
;;   :config
;;   (define-key solidity-mode-map (kbd "C-c C-g") 'solidity-estimate-gas-at-point)
;;   (use-package solidity-flycheck
;;     :ensure t
;;     :after solidity-mode
;;     :config
;;     (setq solidity-flycheck-solc-checker-active t)
;;     (setq solidity-flycheck-solium-checker-active t)
;;     (setq flycheck-solidity-solc-addstd-contracts t)
;;     )
;;   (use-package company-solidity
;;     :ensure t
;;     :after solidity-mode
;;     :config
;;     (add-hook 'solidity-mode-hook
;; 	      (lambda ()
;; 		(set (make-local-variable 'company-backends)
;; 		     (append '((company-solidity company-capf company-dabbrev-code))
;; 			     company-backends))))
;;     )
;;   )
(provide 'init-prog)

