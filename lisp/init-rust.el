(use-package rust-mode
  :init
  (add-to-list 'exec-path "~/.cargo/bin")
  :config
  (use-package racer
    :hook(rust-mode . racer-mode)
    :config
    (setq racer-eldoc-timeout 3)
    )
  (use-package cargo
    :diminish cargo-minor-mode
    :hook (rust-mode . cargo-minor-mode)
    ;; :config
    ;; To render buttons correctly, keep it at the last
    ;; (setq compilation-filter-hook
    ;;       (append compilation-filter-hook '(cargo-process--add-errno-buttons)))
    )
  )

(use-package rust-playground)

(provide 'init-rust)
