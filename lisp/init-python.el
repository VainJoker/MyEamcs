(use-package python 
  :ensure t 
  :defer 2
  :config 
  ;; (use-package lsp-pyright
  ;;   :ensure t
  ;;   :hook (python-mode . (lambda ()
  ;; 			   (require 'lsp-pyright)
  ;; 			   (lsp))))  ; or lsp-deferred
  )
;; :hook (inferior-python-mode . (lambda () 
;; 				  (process-query-on-exit-flag (get-process "Python")))) 
;; :init
;; ;; Disable readline based native completion
;; (setq python-shell-completion-native-enable nil) 
;; :config
;; ;; Default to Python 3. Prefer the versioned Python binaries since some
;; ;; systems stupidly make the unversioned one point at Python 2.
;; (when (and (executable-find "python3") 
;; 	     (string= python-shell-interpreter "python")) 
;;   (setq python-shell-interpreter "python3"))
;; ;; Env vars
;; (with-eval-after-load 'exec-path-from-shell (exec-path-from-shell-copy-env "PYTHONPATH"))
;; ;; Live Coding in Python
;; (use-package lsp-python-ms
;;   :ensure t
;;   :init (setq lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;; 			   (require 'lsp-python-ms)
;; 			   (lsp))))  ; or lsp-deferred
;; (use-package live-py-mode 
;;   :ensure t)
;; (use-package python-black
;;   :ensure t
;;   :hook (python-mode . python-black-on-save-mode))
;; )

(provide 'init-python)
