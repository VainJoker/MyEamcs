(use-package rustic
  :init
  (add-to-list 'exec-path "~/.cargo/bin")
  (setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
  :config
  (use-package cargo
    :diminish cargo-minor-mode
    :hook (rust-mode . cargo-minor-mode)
    :bind
    ("C-c C-r" . cargo-process-run)
    ;; :config
    ;; To render buttons correctly, keep it at the last
    ;; (setq compilation-filter-hook
    ;;       (append compilation-filter-hook '(cargo-process--add-errno-buttons)))
    )
(use-package rust-playground)
  )
;; (use-package rust-mode
;;   :init
;;   (add-to-list 'exec-path "~/.cargo/bin")
;;   :config
;;   (use-package racer
;;     :hook(rust-mode . racer-mode)
;;     :config
;;     (setq racer-eldoc-timeout 3)
;;     )
;;   )


(provide 'init-rust)
