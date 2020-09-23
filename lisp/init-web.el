;; Major mode for editing web templates
(use-package web-mode
  :mode "\\.\\(phtml\\|php|[gj]sp\\|as[cp]x\\|erb\\|djhtml\\|html?\\|hbs\\|ejs\\|jade\\|swig\\|tm?pl\\|vue\\)$"
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))


(use-package typescript-mode
  :defer 2
  :ensure t
  :mode "\\.ts\\'"
  :commands (typescript-mode)
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode-hook 'web-dev-attached)
  )

(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1)
    (company-box-mode +1)
    )
  (setq company-tooltip-align-annotations t)
  (add-hook 'typescript-mode-hook #'setup-tide-mode)
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  )


;; Format HTML, CSS and JavaScript/JSON
;; Install: npm -g install prettier
(use-package prettier-js
  :diminish
  :hook ((js-mode js2-mode json-mode web-mode css-mode sgml-mode html-mode)
         .
         prettier-js-mode))

(use-package haml-mode)
(use-package php-mode)


;; REST
(use-package restclient
  :mode ("\\.http\\'" . restclient-mode)
  :config
  (use-package restclient-test
    :diminish
    :hook (restclient-mode . restclient-test-mode))

  (with-eval-after-load 'company
    (use-package company-restclient
      :defines company-backends
      :init (add-to-list 'company-backends 'company-restclient))))

(use-package emmet-mode
  :init (setq emmet-expand-jsx-className? t)
  :hook (web-mode vue-mode typescript-mode js-mode)
  )
;; (use-package zencoding-mode
;;   :ensure t
;;   :config
;;   (add-hook 'web-mode-hook 'zencoding-mode)
;;   )

(use-package css-mode
  :defer 2
  :ensure t
  :mode "\\.css\\'"
  :config
  (add-hook 'css-mode-hook (lambda()
                             (add-to-list (make-local-variable 'company-backends)
                                          '(company-css company-files company-yasnippet company-capf))))

  (setq css-indent-offset 2)
  (setq flycheck-stylelintrc "~/.stylelintrc")
  )

(use-package scss-mode
  :defer 2
  :ensure t
  :mode "\\.scss\\'"
  )

(use-package css-eldoc
  :commands turn-on-css-eldoc
  :hook ((css-mode scss-mode less-css-mode) . turn-on-css-eldoc))

;; JSON mode
(use-package json-mode)

;; JavaScript
(use-package js2-mode
  :defines flycheck-javascript-eslint-executable
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :interpreter (("node" . js2-mode)
                ("node" . js2-jsx-mode))
  :hook ((js2-mode . js2-imenu-extras-mode)
         (js2-mode . js2-highlight-unused-variables-mode))
  :config
  (with-eval-after-load 'flycheck
    (when (or (executable-find "eslint_d")
              (executable-find "eslint")
              (executable-find "jshint"))
      (setq js2-mode-show-strict-warnings nil))
    (when (executable-find "eslint_d")
      ;; https://github.com/mantoni/eslint_d.js
      ;; npm -i -g eslint_d
      (setq flycheck-javascript-eslint-executable "eslint_d")))

  (use-package js2-refactor
    :diminish
    :hook (js2-mode . js2-refactor-mode)
    :config (js2r-add-keybindings-with-prefix "C-c C-m")))


(defun web-refreash()
  (interactive)
  (progn
    (save-buffer)
    (other-window 1)
    (eaf-proxy-insert_or_refresh_page)
    )
  )
(defun web-open()
  (interactive)
  (progn
    (split-window-horizontally)
    (other-window 1)
    (eaf-open-browser (concat "file://" buffer-file-name))
    (save-buffer)
    )
  )

(add-hook 'web-mode-hook '(lambda() (local-set-key (kbd "C-c C-p") 'web-refreash)))
(add-hook 'web-mode-hook '(lambda() (local-set-key (kbd "C-c C-z") 'web-open)))

(provide 'init-web)
