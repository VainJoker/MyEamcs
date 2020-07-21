(use-package eaf
  :defer 2
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (require 'eaf-evil)
  (eaf-setq eaf-browser-dark-mode "false")
  (eaf-setq eaf-mindmap-dark-mode "true")
  (eaf-setq eaf-pdf-dark-mode "true")
  (eaf-setq eaf-browser-default-zoom "1.5")
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (setq eaf-proxy-type "socks5")
  (setq eaf-proxy-host "127.0.0.1")
  (setq eaf-proxy-port "1080")
  )

(provide 'init-eaf)
