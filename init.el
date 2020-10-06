;; Speed up startup
(defvar vainjoker-gc-cons-threshold (if (display-graphic-p) 16000000 1600000)
  "The default value to use for `gc-cons-threshold'. If you experience freezing,
  decrease this. If you experience stuttering, increase this.")

(defvar vainjoker-gc-cons-upper-limit (if (display-graphic-p) 400000000 100000000)
  "The temporary value for `gc-cons-threshold' to defer it.")

(defvar vainjoker-gc-timer (run-with-idle-timer 10 t #'garbage-collect)
  "Run garbarge collection when idle 10s.")
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold vainjoker-gc-cons-upper-limit
      gc-cons-percentage 0.5)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after startup."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold vainjoker-gc-cons-threshold
                  gc-cons-percentage 0.1)
            ;; GC automatically while unfocusing the frame
            ;; `focus-out-hook' is obsolete since 27.1
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                  (lambda ()
                    (unless (frame-focus-state)
                      (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))
            (defun my-minibuffer-setup-hook ()
              (setq gc-cons-threshold vainjoker-gc-cons-upper-limit))
            (defun my-minibuffer-exit-hook ()
              (setq gc-cons-threshold vainjoker-gc-cons-threshold))
            (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)))
(when (display-graphic-p)
  (set-face-attribute
   'default nil
   :font (font-spec :name "-CYEL-Iosevka-bold-normal-normal-*-22-*-*-*-d-0-iso10646-1"
                    :weight 'normal
                    :slant 'normal
                    :size 14.0))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name "-WenQ-WenQuanYi Zen Hei-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                :weight 'normal
                :slant 'normal
                :size 15.0)))
  )
(setq byte-compile-warnings '(cl-functions))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(defvar vainjoker-dumped nil
  "non-nil when a dump file is loaded (because dump.el sets this variable).")
(defmacro vainjoker-if-dump (then &rest else)
  "Evaluate IF if running with a dump file, else evaluate ELSE."
  (declare (indent 1))
  `(if vainjoker-dumped
       ,then
     ,@else))
(defun vainjoker-dump ()
  "Dump Emacs."
  (interactive)
  (let ((buf "*dump process*"))
    (make-process
     :name "dump"
     :buffer buf
     :command (list "emacs" "--batch" "-q"
                    "-l" (expand-file-name "dump.el"
                                           user-emacs-directory)))
    (display-buffer buf)))
(vainjoker-if-dump
    (progn
      (setq load-path vainjoker-dumped-load-path)
      (global-font-lock-mode)
      (transient-mark-mode)
      (add-hook 'after-init-hook
                (lambda ()
                  (save-excursion
                    (switch-to-buffer "*scratch*")
                    (lisp-interaction-mode)))))
  ;; add load-path’s and load autoload files
  (package-initialize))
;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(update-load-path)

                                        ; (add-to-list 'load-path "~/.emacs.d/lisp")
                                        ; (add-to-list 'load-path "~/.emacs.d/site-lisp")
                                        ; (add-to-list 'load-path "~/.emacs.d/var/themes")

;; Packages
(require 'init-package)
(require 'init-evil)
(require 'init-ui)
(require 'init-keybinds)
(require 'init-ivy)
(require 'init-filemanager)
(require 'init-basic)
(require 'init-utils)
(require 'init-dashboard)

(require 'init-yasnippet)
(require 'init-company)
(require 'init-lsp)

(require 'init-eaf)
(require 'init-calendar)
(require 'init-highlight)
(require 'init-kill-ring)

(require 'init-git)
(require 'init-window)
(require 'init-persp)

(require 'init-projectile)
(require 'init-flycheck)
(require 'init-prog)
(require 'init-termshell)

(require 'init-c)
(require 'init-go)
(require 'init-rust)
(require 'init-docker)
(require 'init-python)
(require 'init-web)
(require 'init-tex)
(require 'init-rust)
(require 'init-org)
(require 'init-markdown)

(require 'init-edit)
(require 'init-language)
(require 'init-autoinsert)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
