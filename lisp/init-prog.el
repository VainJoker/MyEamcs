(use-package prog-mode
  :ensure nil
  :hook (prog-mode . prettify-symbols-mode)
  :init
  (setq prettify-symbols-unprettify-at-point 'right-edge))

; ;; Jump to definition
; (use-package dumb-jump
;   :pretty-hydra
;   ((:title (pretty-hydra-title "Dump Jump" 'faicon "anchor")
;     :color blue :quit-key "q")
;    ("Jump"
;     (("j" dumb-jump-go "Go")
;      ("o" dumb-jump-go-other-window "Go other window")
;      ("e" dumb-jump-go-prefer-external "Go external")
;      ("x" dumb-jump-go-prefer-external-other-window "Go external other window"))
;     "Other"
;     (("i" dumb-jump-go-prompt "Prompt")
;      ("l" dumb-jump-quick-look "Quick look")
;      ("b" dumb-jump-back "Back"))))
;   :bind (("M-g o" . dumb-jump-go-other-window)
;          ("M-g j" . dumb-jump-go)
;          ("M-g i" . dumb-jump-go-prompt)
;          ("M-g x" . dumb-jump-go-prefer-external)
;          ("M-g z" . dumb-jump-go-prefer-external-other-window)
;          ("C-M-j" . dumb-jump-hydra/body))
;   :init
;   (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;   (setq dumb-jump-prefer-searcher 'rg
;         dumb-jump-selector 'ivy))

(use-package editorconfig
  :diminish
  :hook (after-init . editorconfig-mode))

;; Run commands quickly
(use-package quickrun
  :bind (("C-<f5>" . quickrun)
         ("C-c x" . quickrun)))

(use-package cask-mode)
(use-package csharp-mode)
(use-package csv-mode)
(use-package julia-mode)
(use-package lua-mode)
(use-package mermaid-mode)
(use-package plantuml-mode)
(use-package powershell)
(use-package rmsbolt)                   ; A compiler output viewer
(use-package scala-mode)
(use-package swift-mode)
(use-package vimrc-mode)

(use-package protobuf-mode
  :hook (protobuf-mode . (lambda ()
                           (setq imenu-generic-expression
                                 '((nil "^[[:space:]]*\\(message\\|service\\|enum\\)[[:space:]]+\\([[:alnum:]]+\\)" 2))))))

(use-package nxml-mode
  :ensure nil
  :mode (("\\.xaml$" . xml-mode)))

;; New `conf-toml-mode' in Emacs 26
(unless (fboundp 'conf-toml-mode)
  (use-package toml-mode))

;; Batch Mode eXtras
(use-package bmx-mode
  :after company
  :diminish
  :hook (after-init . bmx-mode-setup-defaults))

;; Fish shell
(use-package fish-mode
  :hook (fish-mode . (lambda ()
                       (add-hook 'before-save-hook
                                 #'fish_indent-before-save))))

(provide 'init-prog)
