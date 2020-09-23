  (setq user-full-name "VainJoker"
        user-mail-address "vainjoker@163.com")
  (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
               ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Should set before loading `use-package'
(eval-and-compile
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  (setq use-package-expand-minimally t)
  (setq use-package-enable-imenu-support t))

(eval-when-compile
  (require 'use-package))

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

;; Update GPG keyring for GNU ELPA
(use-package gnu-elpa-keyring-update)

;; Initialization benchmark
  (use-package benchmark-init
    :defines swiper-font-lock-exclude
    :commands (benchmark-init/activate)
    :hook (after-init . benchmark-init/deactivate)
    :init (benchmark-init/activate)
    :config
    (with-eval-after-load 'swiper
      (add-to-list 'swiper-font-lock-exclude 'benchmark-init/tree-mode)))

;; A modern Packages Menu
(use-package paradox
  :init
  (setq paradox-execute-asynchronously t
        paradox-github-token t
        paradox-display-star-count nil)

  ;; Replace default `list-packages'
  (defun my-paradox-enable (&rest _)
    "Enable paradox, overriding the default package-menu."
    (paradox-enable))
  (advice-add #'list-packages :before #'my-paradox-enable)
  :config
  (when (fboundp 'page-break-lines-mode)
    (add-hook 'paradox-after-execute-functions
              (lambda (&rest _)
                (let ((buf (get-buffer-create "*Paradox Report*"))
                      (inhibit-read-only t))
                  (with-current-buffer buf
                    (page-break-lines-mode 1))))
              t)))

;; Auto update packages
(use-package auto-package-update
  :init
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (defalias 'upgrade-packages #'auto-package-update-now))

(provide 'init-package)

; (require 'init-funcs)
; (require 'init-custom)
  ;; Select the package archives
;   (if (or (executable-find "curl") (executable-find "wget"))
;       (progn
;         ;; Get and select the fastest package archives automatically
;         (message "Testing connection... Please wait a moment.")
;         (set-package-archives
;          (vainjoker-test-package-archives 'no-chart)))
;     ;; Select package archives manually
;     ;; Use `ido-completing-read' for better experience since
;     ;; `ivy-mode' is not available at this moment.
;     (set-package-archives
;      (intern
;       (ido-completing-read
;        "Select package archives: "
;        (mapcar #'symbol-name
;                (mapcar #'car vainjoker-package-archives-alist))))))
; (and (file-readable-p custom-file) (load custom-file))
; ;; Load custom-post file
; (defun load-custom-post-file ()
; "Load custom-post file."
; (cond ((file-exists-p vainjoker-custom-post-org-file)
;        (and (fboundp 'org-babel-load-file)
;             (org-babel-load-file vainjoker-custom-post-org-file)))
;       ((file-exists-p vainjoker-custom-post-file)
;        (load vainjoker-custom-post-file))))
; (add-hook 'after-init-hook #'load-custom-post-file)
; ;; HACK: DO NOT copy package-selected-packages to init/custom file forcibly.
; ;; https://github.com/jwiegley/use-package/issues/383#issuecomment-247801751
; (defun my-save-selected-packages (&optional value)
;   "Set `package-selected-packages' to VALUE but don't save to `custom-file'."
;   (when value
;     (setq package-selected-packages value)))
; (advice-add 'package--save-selected-packages :override #'my-save-selected-packages)
;
; ;; Set ELPA packages
; (set-package-archives vainjoker-package-archives nil nil t)
;
; ;; Initialize packages
; (unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
;   (setq package-enable-at-startup nil)          ; To prevent initializing twice
;   (package-initialize))
;
