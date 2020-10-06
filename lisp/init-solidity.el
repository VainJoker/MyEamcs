(use-package solidity-mode
  :config
  (define-key solidity-mode-map (kbd "C-c C-g") 'solidity-estimate-gas-at-point)
  (setq solidity-solc-path "/usr/bin/solc")
  (use-package solidity-flycheck)
  (use-package company-solidity)
  (add-hook 'solidity-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   (append '((company-solidity company-capf company-dabbrev-code))
			               company-backends))))
  )
