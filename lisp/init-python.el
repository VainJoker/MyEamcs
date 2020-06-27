;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; See the following note about how I set up python + virtualenv to
;; work seamlessly with Emacs:
;; https://gist.github.com/purcell/81f76c50a42eee710dcfc9a14bfc7240


; (setq auto-mode-alist
;       (append '(("SConstruct\\'" . python-mode)
;                 ("SConscript\\'" . python-mode))
;               auto-mode-alist))
;
; (setq python-shell-interpreter "python3")
;
; (require-package 'pip-requirements)
;
; (when (maybe-require-package 'anaconda-mode)
;   (after-load 'python
;     ;; Anaconda doesn't work on remote servers without some work, so
;     ;; by default we enable it only when working locally.
;     (add-hook 'python-mode-hook
;               (lambda () (unless (file-remote-p default-directory)
;                       (anaconda-mode 1))))
;     (add-hook 'anaconda-mode-hook 'anaconda-eldoc-mode))
;   (after-load 'anaconda-mode
;     (define-key anaconda-mode-map (kbd "M-?") nil))
;   (when (maybe-require-package 'company-anaconda)
;     (after-load 'company
;       (after-load 'python
;         (push 'company-anaconda company-backends)))))
;
; (when (maybe-require-package 'toml-mode)
;   (add-to-list 'auto-mode-alist '("poetry\\.lock\\'" . toml-mode)))
;
; (when (maybe-require-package 'reformatter)
;   (reformatter-define black :program "black"))

					; (use-package lsp-python-ms
					;         :ensure t
					;         :hook (python-mode . (lambda ()
					;                                (require 'lsp-python-ms)
					;                                (lsp)))
					;         :custom
					;         (lsp-python-ms-executable "~/.emacs.d/var/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer"))

					; (use-package insert-translated-name
					;   :load-path "~/.emacs.d/site-lisp/insert-translated-name"
					;   :bind (:map leader-key
					;               ("c n i" . #'insert-translated-name-insert)
					;               ("c n r" . #'insert-translated-name-replace))
					;   :config
					;   (which-key-add-prefix-title
					;     "M-SPC c n" "insert-translated-name"))


(provide 'init-python)
;;; init-python.el ends here
