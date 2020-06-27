(use-package web-mode
  :defer 2
  :ensure t
  :mode (
	 ("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode) 
	 ("\\.as[cp]x\\'" . web-mode) 
	 ("\\.erb\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode)
	 ("\\.hbs\\'" . web-mode)   
))

(use-package css-mode
  :defer 2
  :ensure t
  :mode (
	 ("\\.css\\'" . css-mode)
	 )
  )
 

(use-package scss-mode
  :defer 2
  :ensure t
  )

(use-package js2-mode
  :defer 2
  :ensure t
  )

(use-package vue-mode
  :defer 2
  :ensure t
  :mode (
	 ("\\.vue\\'" . vue-mode)
	 ))

(use-package emmet-mode
  :defer 2
  :ensure t
  )

(use-package company-web
  :defer 2
  :ensure t
  )

;;; Colourise CSS colour literals
; (when (maybe-require-package 'rainbow-mode)
;   (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
;     (add-hook hook 'rainbow-mode)))
; ;;; Embedding in html
; (require-package 'mmm-mode)
; (after-load 'mmm-vars
;   (mmm-add-group
;    'html-css
;    '((css-cdata
;       :submode css-mode
;       :face mmm-code-submode-face
;       :front "<style[^>]*>[ \t\n]*\\(//\\)?<!\\[CDATA\\[[ \t]*\n?"
;       :back "[ \t]*\\(//\\)?]]>[ \t\n]*</style>"
;       :insert ((?c css-tag nil @ "<style type=\"text/css\">"
;                    @ "\n" _ "\n" @ "</style>" @)))
;      (css
;       :submode css-mode
;       :face mmm-code-submode-face
;       :front "<style[^>]*>[ \t]*\n?"
;       :back "[ \t]*</style>"
;       :insert ((?c css-tag nil @ "<style type=\"text/css\">"
;                    @ "\n" _ "\n" @ "</style>" @)))
;      (css-inline
;       :submode css-mode
;       :face mmm-code-submode-face
;       :front "style=\""
;       :back "\"")))
;   (dolist (mode (list 'html-mode 'nxml-mode))
;     (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-css)))
; ;;; SASS and SCSS
; (require-package 'sass-mode)
; (unless (fboundp 'scss-mode)
;   ;; Prefer the scss-mode built into Emacs
;   (require-package 'scss-mode))
; (setq-default scss-compile-at-save nil)
; ;;; LESS
; (unless (fboundp 'less-css-mode)
;   ;; Prefer the scss-mode built into Emacs
;   (require-package 'less-css-mode))
; (when (maybe-require-package 'skewer-less)
;   (add-hook 'less-css-mode-hook 'skewer-less-mode))
; ;; Skewer CSS
; (when (maybe-require-package 'skewer-mode)
;   (add-hook 'css-mode-hook 'skewer-css-mode))
; ;;; Use eldoc for syntax hints
; (require-package 'css-eldoc)
; (autoload 'turn-on-css-eldoc "css-eldoc")
; (add-hook 'css-mode-hook 'turn-on-css-eldoc)
;

; (maybe-require-package 'json-mode)
; (maybe-require-package 'js2-mode)
; (maybe-require-package 'coffee-mode)
; (maybe-require-package 'typescript-mode)
; (maybe-require-package 'prettier-js)
;
; ;; Need to first remove from list if present, since elpa adds entries too, which
; ;; may be in an arbitrary order
;
; (add-to-list 'auto-mode-alist '("\\.\\(js\\|es6\\)\\(\\.erb\\)?\\'" . js2-mode))
;
; ;; js2-mode
;
; ;; Change some defaults: customize them to override
; (setq-default js2-bounce-indent-p nil)
; (after-load 'js2-mode
;   ;; Disable js2 mode's syntax error highlighting by default...
;   (setq-default js2-mode-show-parse-errors nil
;                 js2-mode-show-strict-warnings nil)
;   ;; ... but enable it if flycheck can't handle javascript
;   (autoload 'flycheck-get-checker-for-buffer "flycheck")
;   (defun sanityinc/enable-js2-checks-if-flycheck-inactive ()
;     (unless (flycheck-get-checker-for-buffer)
;       (setq-local js2-mode-show-parse-errors t)
;       (setq-local js2-mode-show-strict-warnings t)))
;   (add-hook 'js2-mode-hook 'sanityinc/enable-js2-checks-if-flycheck-inactive)
;
;   (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))
;
;   (js2-imenu-extras-setup))
;
; (setq-default js-indent-level 2)
; ;; In Emacs >= 25, the following is an alias for js-indent-level anyway
; (setq-default js2-basic-offset 2)
;
;
; (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
;
; 
;
; (when (and (executable-find "ag")
;            (maybe-require-package 'xref-js2))
;   (after-load 'js2-mode
;     (define-key js2-mode-map (kbd "M-.") nil)
;     (add-hook 'js2-mode-hook
;               (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))))
;
;
; 
; ;;; Coffeescript
;
; (after-load 'coffee-mode
;   (setq-default coffee-js-mode 'js2-mode
;                 coffee-tab-width js-indent-level))
;
; (when (fboundp 'coffee-mode)
;   (add-to-list 'auto-mode-alist '("\\.coffee\\.erb\\'" . coffee-mode)))
;
; ;; ---------------------------------------------------------------------------
; ;; Run and interact with an inferior JS via js-comint.el
; ;; ---------------------------------------------------------------------------
;
; (when (maybe-require-package 'js-comint)
;   (setq js-comint-program-command "node")
;
;   (defvar inferior-js-minor-mode-map (make-sparse-keymap))
;   (define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
;   (define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
;
;   (define-minor-mode inferior-js-keys-mode
;     "Bindings for communicating with an inferior js interpreter."
;     nil " InfJS" inferior-js-minor-mode-map)
;
;   (dolist (hook '(js2-mode-hook js-mode-hook))
;     (add-hook hook 'inferior-js-keys-mode)))
;
; ;; ---------------------------------------------------------------------------
; ;; Alternatively, use skewer-mode
; ;; ---------------------------------------------------------------------------
;
; (when (maybe-require-package 'skewer-mode)
;   (after-load 'skewer-mode
;     (add-hook 'skewer-mode-hook
;               (lambda () (inferior-js-keys-mode -1)))))
;
;
; 
; (when (maybe-require-package 'add-node-modules-path)
;   (after-load 'typescript-mode
;     (add-hook 'typescript-mode-hook 'add-node-modules-path))
;   (after-load 'js2-mode
;     (add-hook 'js2-mode-hook 'add-node-modules-path)))
;
(provide 'init-web)
