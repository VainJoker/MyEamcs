(use-package flycheck
  :defer 2
  :ensure t
  :init (global-flycheck-mode -1)
  :config
  (which-key-add-key-based-replacements
    "M-SPC t t" "开关flycheck")
  ;; 美化一下
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  ;; 用GUI tooltips来显示检查到的错误
  (use-package flycheck-posframe
        :ensure t
        :custom-face (flycheck-posframe-border-face ((t (:inherit default))))
        :hook (flycheck-mode . flycheck-posframe-mode)
        :init (setq flycheck-posframe-border-width 1
                    flycheck-posframe-inhibit-functions
                    '((lambda (&rest _) (bound-and-true-p company-backend))))
    (use-package flycheck-pos-tip
      :ensure t
      :defines flycheck-pos-tip-timeout
      :hook (global-flycheck-mode . flycheck-pos-tip-mode)
      :config (setq flycheck-pos-tip-timeout 30)))
  (use-package flycheck-popup-tip
    :ensure t
    :hook (flycheck-mode . flycheck-popup-tip-mode))
  )

(use-package lsp-ui
  :defer 2
  :ensure t
  ;; :hook
  ;; ((lsp . lsp-ui-sideline-mode-hook)
   ;; (lsp . lsp-ui-doc-mode-hook)
   ;; (lsp . lsp-ui-imenu-mode-hook)
   ;; (lsp . lsp-ui-peek-mode-hook)
   ;; )
  :config
  (setq lsp-ui-doc-mode 1)
  :custom
  (lsp-ui-doc-delay 1)
  ;; (lsp-ui-doc-mode 0)
  )


(use-package yasnippet
  :defer 5
  :ensure t
  :config
  ;; (yas-reload-all)
  (yas-global-mode)
  ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; (add-hook 'org-mode-hook #'yas-minor-mode)
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"                 ;; personal snippets
	  ))
  )

(use-package yasnippet-snippets
  :defer 5
  :ensure t
  )



;; (use-package yasnippet
;;   :defer 2
;;   :diminish yas-minor-mode
;;   ;; :init (yas-global-mode)
;;   :config
;;   (progn
;;     (yas-global-mode)
;;     (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
;;     (setq yas-key-syntaxes '("w_" "w_." "^ "))
;;     (setq yas-installed-snippets-dir "~/elisp/yasnippet-snippets")
;;     (setq yas-expand-only-for-last-commands nil)
;;     (bind-key "\t" 'hippie-expand yas-minor-mode-map)
;;     (add-to-list 'yas-prompt-functions 'shk-yas/helm-prompt)))

;; (dolist (command '(yank yank-pop))
;;   (eval
;;    `(defadvice ,command (after indent-region activate)
;;       (and (not current-prefix-arg)
;;            (member major-mode
;;                    '(emacs-lisp-mode
;;                      lisp-mode
;;                      clojure-mode
;;                      scheme-mode
;;                      haskell-mode
;;                      ruby-mode
;;                      rspec-mode
;;                      python-mode
;;                      c-mode
;;                      c++-mode
;;                      objc-mode
;;                      latex-mode
;;                      js-mode
;;                      plain-tex-mode))
;;            (let ((mark-even-if-inactive transient-mark-mode))
;;              (indent-region (region-beginning) (region-end) nil))))))

;; (defun shk-yas/helm-prompt (prompt choices &optional display-fn)
;;   "Use helm to select a snippet. Put this into `yas-prompt-functions.'"
;;   (interactive)
;;   (setq display-fn (or display-fn 'identity))
;;   (if (require 'helm-config)
;;       (let (tmpsource cands result rmap)
;;         (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
;;         (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
;;         (setq tmpsource
;;               (list
;;                (cons 'name prompt)
;;                (cons 'candidates cands)
;;                '(action . (("Expand" . (lambda (selection) selection))))
;;                ))
;;         (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
;;         (if (null result)
;;             (signal 'quit "user quit!")
;;           (cdr (assoc result rmap))))
;;     nil))


;; (use-package python
;;   :ensure t
;;   :hook (inferior-python-mode . (lambda ()
;;                                   (process-query-on-exit-flag
;;                                    (get-process "Python"))))
;;   :init
;;   ;; Disable readline based native completion
;;   (setq python-shell-completion-native-enable nil)
;;   :config
;;   ;; Default to Python 3. Prefer the versioned Python binaries since some
;;   ;; systems stupidly make the unversioned one point at Python 2.
;;   (when (and (executable-find "python3")
;;              (string= python-shell-interpreter "python"))
;;     (setq python-shell-interpreter "python3"))
;;   ;; Env vars
;;   (with-eval-after-load 'exec-path-from-shell
;;     (exec-path-from-shell-copy-env "PYTHONPATH"))
;;   ;; Live Coding in Python
;;   (use-package live-py-mode
;;     :ensure t))


(provide 'init-prog)

