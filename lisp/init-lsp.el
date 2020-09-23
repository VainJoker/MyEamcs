(use-package lsp-mode
  :defines (lsp-clients-python-library-directories
            lsp-rust-server)
  :commands (lsp-enable-which-key-integration
             lsp-format-buffer
             lsp-organize-imports
             lsp-install-server)
  :diminish
  :hook ((prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                          (lsp-deferred))))
         (lsp-mode . (lambda ()
                       ;; Integrate `which-key'
                       (lsp-enable-which-key-integration)

                       ;; Format and organize imports
                       ;; (unless (apply #'derived-mode-p centaur-lsp-format-on-save-ignore-modes)
                         (add-hook 'before-save-hook #'lsp-format-buffer t t)
                         (add-hook 'before-save-hook #'lsp-organize-imports t t))))
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point)
              ([remap xref-find-definitions] . lsp-find-definition)
              ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://emacs-lsp.github.io/lsp-mode/page/performance
  (setq read-process-output-max (* 1024 1024)) ;; 1MB

  (setq lsp-keymap-prefix "C-c L"
        lsp-keep-workspace-alive nil
        lsp-signature-auto-activate nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil

        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-semantic-highlighting nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-text-document-color nil

        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil)

  ;; For `lsp-clients'
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  (when (executable-find "rust-analyzer")
    (setq lsp-rust-server 'rust-analyzer))
  :config
  (with-no-warnings
    (defun my-lsp--init-if-visible (func &rest args)
      "Not enabling lsp in `git-timemachine-mode'."
      (unless (bound-and-true-p git-timemachine-mode)
        (apply func args)))
    (advice-add #'lsp--init-if-visible :around #'my-lsp--init-if-visible))

  (defun lsp-update-server ()
    "Update LSP server."
    (interactive)
    ;; Equals to `C-u M-x lsp-install-server'
    (lsp-install-server t)))

(use-package lsp-ui
  :custom-face
  (lsp-ui-sideline-code-action ((t (:inherit warning))))
  :bind (("C-c u" . lsp-ui-imenu)
         :map lsp-ui-mode-map
         ("M-RET" . lsp-ui-sideline-apply-code-actions))
  :hook (lsp-mode . lsp-ui-mode)
  :init (setq lsp-ui-sideline-show-diagnostics nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-doc-position 'at-point
              lsp-ui-doc-border (face-foreground 'font-lock-comment-face)
              lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                                    ,(face-foreground 'font-lock-string-face)
                                    ,(face-foreground 'font-lock-constant-face)
                                    ,(face-foreground 'font-lock-variable-name-face)))
  :config
  ;; `C-g'to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook
            (lambda ()
              (setq lsp-ui-doc-border (face-foreground 'font-lock-comment-face))
              (set-face-background 'lsp-ui-doc-background (face-background 'tooltip)))))

;; Ivy integration
(use-package lsp-ivy
  :after lsp-mode
  :bind (:map lsp-mode-map
              ([remap xref-find-apropos] . lsp-ivy-workspace-symbol)
              ("C-s-." . lsp-ivy-global-workspace-symbol)))

;; Debug
(use-package dap-mode
  :defines dap-python-executable
  :diminish
  :bind (:map lsp-mode-map
              ("<f5>" . dap-debug)
              )
  :hook ((after-init . dap-mode)
         (dap-mode . dap-ui-mode)
         )

         (python-mode . (lambda () (require 'dap-python)))
         (ruby-mode . (lambda () (require 'dap-ruby)))
         (go-mode . (lambda () (require 'dap-go)))
         (java-mode . (lambda () (require 'dap-java)))
         ((c-mode c++-mode objc-mode swift-mode) . (lambda () (require 'dap-lldb)))
         (php-mode . (lambda () (require 'dap-php)))
         (elixir-mode . (lambda () (require 'dap-elixir)))
         ((js-mode js2-mode) . (lambda () (require 'dap-chrome)))
         (powershell-mode . (lambda () (require 'dap-pwsh))))
  :init
  (setq dap-auto-configure-features '(sessions locals breakpoints expressions controls))
  (when (executable-find "python3")
    (setq dap-python-executable "python3"))

;; Python: pyright
(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :init (when (executable-find "python3")
          (setq lsp-pyright-python-executable-cmd "python3")))

;; C/C++/Objective-C support
(use-package ccls
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json" ".ccls")
                  projectile-project-root-files-top-down-recurring))))

;; Julia support
(use-package lsp-julia
  :hook (julia-mode . (lambda () (require 'lsp-julia))))

;; Java support
(use-package lsp-java
  :hook (java-mode . (lambda () (require 'lsp-java))))

(provide 'init-lsp)

                                        ; (use-package lsp-mode
                                        ;   :ensure t
                                        ;   :defer 2
                                        ;   :custom
                                        ;   (lsp-prefer-capf t)
                                        ;   :init
                                        ;   (let ((lsp-keymap-prefix "nil")))
                                        ;   (let ((lsp-keymap-prefix "SPC l")))
                                        ;   ;; (lsp-log-io t)
                                        ;   :hook
                                        ;   (auctex . lsp)
                                        ;   (go-mode . lsp)
                                        ;   (c-mode . lsp)
                                        ;   (lisp-mode .lsp)
                                        ;   (emacs-lisp-mode .lsp)
                                        ;   (js2-mode-hook .lsp)
                                        ;   (js-mode . lsp)
                                        ;   (rust-mode .lsp)
                                        ;   (web-mode . lsp)
                                        ;   (mhtml-mode . lsp)
                                        ;   (vue-mode . lsp)
                                        ;   (lua-mode . lsp)
                                        ;   ;; (lsp . company-capf)
                                        ;   ;; (python-mode . lsp)
                                        ;   ;; if you want which-key integration
                                        ;   (lsp-mode . lsp-enable-which-key-integration)
                                        ;   ;; )
                                        ;   :config
                                        ;   (setq read-process-output-max (* 1024 1024)) ;; 1MB
                                        ;   (advice-add #'lsp--auto-configure :override #'ignore)
                                        ;   (setq lsp-auto-guess-root 0)
                                        ;   (setq lsp-auto-configure 1)
                                        ;   ;; (setq lsp-keep-workspace-alive nil
                                        ;   ;; 	lsp-prefer-capf t
                                        ;   ;; 	lsp-signature-auto-activate nil
                                        ;   ;; 	lsp-eldoc-render-all nil
                                        ;   ;; 	;; lsp-signature-doc-lines 2
                                        ;   ;; 	lsp-modeline-code-actions-enable nil
                                        ;   ;; 	lsp-enable-file-watchers nil
                                        ;   ;; 	lsp-enable-file-watchers nil
                                        ;   ;; 	lsp-enable-folding nil
                                        ;   ;; 	lsp-enable-semantic-highlighting nil
                                        ;   ;; 	lsp-enable-symbol-highlighting nil
                                        ;   ;; 	lsp-enable-text-document-color nil
                                        ;   ;; 	lsp-enable-indentation nil
                                        ;   ;; 	lsp-enable-on-type-formatting nil)
                                        ;   (use-package lsp-ui
                                        ;     :ensure t
                                        ;     :defer 2
                                        ;     ;; :hook
                                        ;     ;; ((lsp . lsp-ui-sideline-mode-hook)
                                        ;     ;; (lsp . lsp-ui-doc-mode-hook)
                                        ;     ;; (lsp . lsp-ui-imenu-mode-hook)
                                        ;     ;; (lsp . lsp-ui-peek-mode-hook)
                                        ;     ;; )
                                        ;     :config
                                        ;     (setq lsp-ui-doc-mode nil)
                                        ;     :custom
                                        ;     (lsp-ui-doc-delay 3)
                                        ;     ;; (lsp-ui-doc-mode 0)
                                        ;     )
                                        ;   (use-package dap-mode
                                        ;     :ensure t
                                        ;     :defer 2
                                        ;     :config
                                        ;     (setq dap-auto-configure-features '(sessions locals controls tooltip))
                                        ;     (require 'dap-go)
                                        ;     )
                                        ;   )
                                        ;
                                        ; (use-package eglot
                                        ;   :ensure t
                                        ;   :defer 2
                                        ;   :config
                                        ;   ;; (add-hook 'js2-mode-hook 'eglot-ensure)
                                        ;   (add-hook 'python-mode-hook 'eglot-ensure)
                                        ;   ;; (add-hook 'lua-mode-hook 'eglot-ensure)
                                        ;   ;; (add-hook 'rust-mode-hook 'eglot-ensure)
                                        ;   )
                                        ;
                                        ;
                                        ;   ;; (use-package nox
                                        ;   ;;   :defer 2
                                        ;   ;;   :load-path "~/.emacs.d/site-lisp/nox"
                                        ;   ;;   :config
                                        ;   ;;   (dolist (hook (list
                                        ;   ;; 		 'js-mode-hook
                                        ;   ;; 		 'rust-mode-hook
                                        ;   ;; 		 'python-mode-hook
                                        ;   ;; 		 'ruby-mode-hook
                                        ;   ;; 		 'java-mode-hook
                                        ;   ;; 		 'sh-mode-hook
                                        ;   ;; 		 'php-mode-hook
                                        ;   ;; 		 'c-mode-common-hook
                                        ;   ;; 		 'go-mode-hook
                                        ;   ;; 		 'c-mode-hook
                                        ;   ;; 		 'c++-mode-hook
                                        ;   ;; 		 'haskell-mode-hook
                                        ;   ;; 		 'lisp-mode-hook
                                        ;   ;; 		 ))
                                        ;   ;;     (add-hook hook '(lambda () (nox-ensure))))
                                        ;   ;;   )
