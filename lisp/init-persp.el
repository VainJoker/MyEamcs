;; (use-package persp-mode
;;   :diminish
;;   :defines (recentf-exclude ivy-ignore-buffers)
;;   :commands (get-current-persp persp-contain-buffer-p)
;;   :hook ((after-init . persp-mode)
;;          (persp-mode . persp-load-frame)
;;          (kill-emacs . persp-save-frame))
;;   :init (setq persp-keymap-prefix (kbd "C-x p")
;;               persp-nil-name "default"
;;               persp-set-last-persp-for-new-frames nil
;;               persp-kill-foreign-buffer-behaviour 'kill
;;       )
;;   :config
;;   ;; Save and load frame parameters (size & position)
;;   (defvar persp-frame-file (expand-file-name "persp-frame" persp-save-dir)
;;     "File of saving frame parameters.")

;;   (defun persp-save-frame ()
;;     "Save the current frame parameters to file."
;;     (interactive)
;;     (when (and (display-graphic-p) persp-mode)
;;       (condition-case error
;;           (with-temp-buffer
;;             (erase-buffer)
;;             (insert
;;              ";;; -*- mode: emacs-lisp; coding: utf-8-unix -*-\n"
;;              ";;; This is the previous frame parameters.\n"
;;              ";;; Last generated " (current-time-string) ".\n"
;;              "(setq initial-frame-alist\n"
;;              (format "      '((top . %d)\n" (frame-parameter nil 'top))
;;              (format "        (left . %d)\n" (frame-parameter nil 'left))
;;              (format "        (width . %d)\n" (frame-parameter nil 'width))
;;              (format "        (height . %d)\n" (frame-parameter nil 'height))
;;              (format "        (fullscreen . %s)))\n" (frame-parameter nil 'fullscreen)))
;;             (when (file-writable-p persp-frame-file)
;;               (write-file persp-frame-file)))
;;         (error
;;          (warn "persp frame: %s" (error-message-string error))))))

;;   (defun persp-load-frame ()
;;     "Load frame with the previous frame's geometry."
;;     (interactive)
;;     (when (and (display-graphic-p) persp-mode)
;;       (when (file-readable-p persp-frame-file)
;;         (load persp-frame-file)

;;         ;; Handle multiple monitors gracefully
;;         (when (>= (frame-parameter nil 'left) (display-pixel-width))
;;           (set-frame-parameter nil 'left 0))
;;         (when (>= (frame-parameter nil 'top) (display-pixel-height))
;;           (set-frame-parameter nil 'top 0)))))

;;   (with-no-warnings
;;     ;; Don't save if the sate is not loaded
;;     (defvar persp-state-loaded nil
;;       "Whether the state is loaded.")

;;     (defun my-persp-after-load-state (&rest _)
;;       (setq persp-state-loaded t))
;;     (advice-add #'persp-load-state-from-file :after #'my-persp-after-load-state)
;;     (add-hook 'emacs-startup-hook
;;               (lambda ()
;;                 (add-hook 'find-file-hook #'my-persp-after-load-state)))

;;     (defun my-persp-asave-on-exit (fn &optional interactive-query)
;;       (if persp-state-loaded
;;           (funcall fn interactive-query)
;;         t))
;;     (advice-add #'persp-asave-on-exit :around #'my-persp-asave-on-exit))

;;   ;; Don't save dead or temporary buffers
;;   (add-to-list 'persp-filter-save-buffers-functions
;;                (lambda (b)
;;                  "Ignore dead buffers."
;;                  (not (buffer-live-p b))))
;;   (add-to-list 'persp-filter-save-buffers-functions
;;                (lambda (b)
;;                  "Ignore temporary buffers."
;;                  (let ((bname (file-name-nondirectory (buffer-name b))))
;;                    (or (string-prefix-p ".newsrc" bname)
;;                        (string-prefix-p "magit" bname)
;;                        (string-prefix-p "Pfuture-Callback" bname)
;;                        (string-match-p "\\.elc\\|\\.tar\\|\\.gz\\|\\.zip\\'" bname)
;;                        (string-match-p "\\.bin\\|\\.so\\|\\.dll\\|\\.exe\\'" bname)
;;                        (eq (buffer-local-value 'major-mode b) 'erc-mode)
;;                        (eq (buffer-local-value 'major-mode b) 'rcirc-mode)
;;                        (eq (buffer-local-value 'major-mode b) 'nov-mode)
;;                        (eq (buffer-local-value 'major-mode b) 'vterm-mode)))))

;;   ;; Don't save persp configs in `recentf'
;;   (with-eval-after-load 'recentf
;;     (push persp-save-dir recentf-exclude))

;;   ;; Ivy Integraticon
;;   (with-eval-after-load 'ivy
;;     (add-to-list 'ivy-ignore-buffers
;;                  #'(lambda (b)
;;                      (when persp-mode
;;                        (let ((persp (get-current-persp)))
;;                          (if persp
;;                              (not (persp-contain-buffer-p b persp))
;;                            nil))))))

;;   ;; Eshell integration
;;   (persp-def-buffer-save/load
;;    :mode 'eshell-mode :tag-symbol 'def-eshell-buffer
;;    :save-vars '(major-mode default-directory))

;;   ;; Shell integration
;;   (persp-def-buffer-save/load
;;    :mode 'shell-mode :tag-symbol 'def-shell-buffer
;;    :mode-restore-function (lambda (_) (shell))
;;    :save-vars '(major-mode default-directory)))

(provide 'init-persp)
