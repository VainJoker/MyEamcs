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
; )
;; :bind (("M-g o" . dumb-jump-go-other-window)
;          ("M-g j" . dumb-jump-go)
;          ("M-g i" . dumb-jump-go-prompt)
;          ("M-g x" . dumb-jump-go-prefer-external)
;          ("M-g z" . dumb-jump-go-prefer-external-other-window)
;          ("C-M-j" . dumb-jump-hydra/body))
;; :init
;; (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;; )

(use-package editorconfig
  :diminish
  :hook (after-init . editorconfig-mode))

;; Run commands quickly
(use-package quickrun
  :bind ("<f5>" . quickrun)
  
  )

(use-package cask-mode)
(use-package csharp-mode)
(use-package csv-mode)
(use-package julia-mode)
(use-package lua-mode)
(use-package mermaid-mode)
(use-package plantuml-mode)
(use-package powershell)
(use-package rmsbolt)
;; A compiler output viewer
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

(provide 'init-prog)
