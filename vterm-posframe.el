(require 'cl-lib)
(require 'posframe)
(require 'vterm)

(defgroup vterm-posframe nil
  "Using posframe to show vterm"
  :group 'vterm
  :prefix "vterm-posframe")

(defcustom vterm-posframe-style 'window-bottom-left
  "The style of vterm-posframe."
  :group 'vterm-posframe
  :type 'string)

(defcustom vterm-posframe-font nil
  "The font used by vterm-posframe.
When nil, Using current frame's font as fallback."
  :group 'vterm-posframe
  :type 'string)

(defcustom vterm-posframe-width nil
  "The width of vterm-posframe."
  :group 'vterm-posframe
  :type 'number)

(defcustom vterm-posframe-height nil
  "The height of vterm-posframe."
  :group 'vterm-posframe
  :type 'number)

(defcustom vterm-posframe-min-width nil
  "The width of vterm-min-posframe."
  :group 'vterm-posframe
  :type 'number)

(defcustom vterm-posframe-min-height nil
  "The height of vterm-min-posframe."
  :group 'vterm-posframe
  :type 'number)

(defcustom vterm-posframe-size-function #'ivy-posframe-get-size
  "The function which is used to deal with posframe's size."
  :group 'vterm-posframe
  :type 'function)

(defcustom vterm-posframe-border-width 1
  "The border width used by vterm-posframe.
When 0, no border is showed."
  :group 'vterm-posframe
  :type 'number)

(defcustom vterm-posframe-hide-minibuffer t
  "Hide input of minibuffer when using vterm-posframe."
  :group 'vterm-posframe
  :type 'boolean)

(defcustom vterm-posframe-parameters nil
  "The frame parameters used by vterm-posframe."
  :group 'vterm-posframe
  :type 'string)

(defcustom vterm-posframe-height-alist nil
  "The `vterm-height-alist' while working ivy-posframe."
  :group 'vterm-posframe
  :type 'sexp)

(defcustom vterm-posframe-display-functions-alist '((t . ivy-posframe-display))
  "The `vterm-display-functions-alist' while working ivy-posframe."
  :group 'vterm-posframe
  :type 'sexp)

(defcustom vterm-posframe-lighter " ivy-posframe"
  "The lighter string used by `vterm-posframe-mode'."
  :group 'vterm-posframe
  :type 'string)

(defface vterm-posframe
  '((t (:inherit default)))
  "Face used by the vterm-posframe."
  :group 'vterm-posframe)

(defface vterm-posframe-border
  '((t (:inherit default :background "gray50")))
  "Face used by the vterm-posframe's border."
  :group 'vterm-posframe)

(defface vterm-posframe-cursor
  '((t (:inherit cursor)))
  "Face used by the vterm-posframe's fake cursor."
  :group 'vterm-posframe)

(defun vterm-posframe-buffer-setter (sym val)
  "Set SYM as VAL and create buffer named `vterm-posframe-buffer'."
  (set-default sym val)
  (get-buffer-create val))

(defcustom vterm-posframe-buffer " *ivy-posframe-buffer*"
  "The posframe-buffer used by vterm-posframe."
  :set #'vterm-posframe-buffer-setter
  :type 'string
  :group 'vterm-posframe)

(defvar vterm-posframe--ignore-prompt nil
  "When non-nil, vterm-posframe will ignore prompt.
This variable is useful for `vterm-posframe-read-action' .")

;; Fix warn
(defvar emacs-basic-display)
(defvar vterm--display-function)

(defun vterm-posframe--display (str &optional poshandler)
  "Show STR in vterm's posframe with POSHANDLER."
  (if (not (posframe-workable-p))
      (vterm-display-function-fallback str)
    (with-vterm-window
      (apply #'posframe-show
             vterm-posframe-buffer
             :font vterm-posframe-font
             :string str
             :position (point)
             :poshandler poshandler
             :background-color (face-attribute 'vterm-posframe :background nil t)
             :foreground-color (face-attribute 'vterm-posframe :foreground nil t)
             :internal-border-width vterm-posframe-border-width
             :internal-border-color (face-attribute 'vterm-posframe-border :background nil t)
             :override-parameters vterm-posframe-parameters
             (funcall vterm-posframe-size-function))
     (vterm-posframe--add-prompt 'ignore))))

(defun vterm-posframe-get-size ()
  "The default functon used by `vterm-posframe-size-function'."
  (list
   :height vterm-posframe-height
   :width vterm-posframe-width
   :min-height (or vterm-posframe-min-height
                   (let ((height (+ vterm-height 1)))
                     (min height (or vterm-posframe-height height))))
   :min-width (or vterm-posframe-min-width
                  (let ((width (round (* (frame-width) 0.62))))
                    (min width (or vterm-posframe-width width))))))

(defun vterm-posframe-display (str)
  "Display STR via `posframe' by `vterm-posframe-style'."
  (let ((func (intern (format "vterm-posframe-display-at-%s" ivy-posframe-style))))
    (if (functionp func)
        (funcall func str)
      (vterm-posframe-display-at-frame-bottom-left str))))

(defun vterm-posframe-display-at-window-center (str)
  (vterm-posframe--display str #'posframe-poshandler-window-center))

(defun vterm-posframe-display-at-frame-center (str)
  (vterm-posframe--display str #'posframe-poshandler-frame-center))

(defun vterm-posframe-display-at-window-bottom-left (str)
  (vterm-posframe--display str #'posframe-poshandler-window-bottom-left-corner))

(defun vterm-posframe-display-at-frame-bottom-left (str)
  (vterm-posframe--display str #'posframe-poshandler-frame-bottom-left-corner))

(defun vterm-posframe-display-at-frame-bottom-window-center (str)
  (vterm-posframe--display
   str (lambda (info)
         (cons (car (posframe-poshandler-window-center info))
               (cdr (posframe-poshandler-frame-bottom-left-corner info))))))

(defun vterm-posframe-display-at-point (str)
  (vterm-posframe--display str #'posframe-poshandler-point-bottom-left-corner))

(defun vterm-posframe-display-at-frame-top-center (str)
  (vterm-posframe--display str #'posframe-poshandler-frame-top-center))

(defun vterm-posframe-cleanup ()
  "Cleanup vterm's posframe."
  (when (posframe-workable-p)
    (posframe-hide vterm-posframe-buffer)))

(defun vterm-posframe-dispatching-done ()
  "Select one of the available actions and call `vterm-done'."
  (interactive)
  (when (vterm-posframe-read-action)
    (vterm-done)))

(defun vterm-posframe-read-action ()
  "Change the action to one of the available ones.

Return nil for `minibuffer-keyboard-quit' or wrong key during the
selection, non-nil otherwise."
  (interactive)
  (let* ((actions (vterm-state-action ivy-last))
         (caller (vterm-state-caller ivy-last))
         (display-function
          (or vterm--display-function
              (cdr (or (assq caller vterm-display-functions-alist)
                       (assq t vterm-display-functions-alist))))))
    (if (not (vterm--actionp actions))
        t
      (let* ((hint (funcall vterm-read-action-format-function (cdr actions)))
             (resize-mini-windows t)
             (key "")
             action-idx)
        (while (and (setq action-idx (cl-position-if
                                      (lambda (x)
                                        (string-prefix-p key (car x)))
                                      (cdr actions)))
                    (not (string= key (car (nth action-idx (cdr actions))))))
          (setq key (concat key (string
                                 (read-key
                                  (if (functionp display-function)
                                      (let ((vterm-posframe--ignore-prompt t))
                                        (funcall display-function hint)
                                        "Please type a key: ")
                                    hint))))))
        (cond ((member key '("" ""))
               nil)
              ((null action-idx)
               (message "%s is not bound" key)
               nil)
              (t
               (message "")
               (setcar actions (1+ action-idx))
               (vterm-set-action actions)))))))

(defun vterm-posframe--window ()
  "Return the posframe window displaying `vterm-posframe-buffer'."
  (frame-selected-window
   (buffer-local-value 'posframe--frame
                       (get-buffer vterm-posframe-buffer))))

(defvar avy-all-windows)
(defvar avy-keys)
(defvar avy-style)
(defvar avy-pre-action)

(defun vterm-posframe-avy ()
  "Jump to one of the current vterm candidates."
  (interactive)
  (let ((avy-pre-action #'ignore))
    (with-selected-window (vterm-posframe--window)
      (vterm-avy))))

(declare-function avy--make-backgrounds "avy")
(declare-function avy-window-list "avy")
(declare-function avy-read-de-bruijn "avy")
(declare-function avy-read "avy")
(declare-function avy-tree "avy")
(declare-function avy--overlay-post "avy")
(declare-function avy--remove-leading-chars "avy")
(declare-function avy-push-mark "avy")
(declare-function avy--done "avy")
(defun vterm-posframe--swiper-avy-candidate ()
  (let* ((avy-all-windows nil)
         ;; We'll have overlapping overlays, so we sort all the
         ;; overlays in the visible region by their start, and then
         ;; throw out non-Swiper overlays or overlapping Swiper
         ;; overlays.
         (visible-overlays (cl-sort (with-vterm-window
                                      (overlays-in (window-start)
                                                   (window-end)))
                                    #'< :key #'overlay-start))
         (min-overlay-start 0)
         (overlays-for-avy (cl-remove-if-not
                            (lambda (ov)
                              (when (and (>= (overlay-start ov)
                                             min-overlay-start)
                                         (memq (overlay-get ov 'face)
                                               swiper-faces))
                                (setq min-overlay-start (overlay-start ov))))
                            visible-overlays))
         (offset (if (eq (vterm-state-caller ivy-last) 'swiper) 1 0))
         (window (vterm-posframe--window))
         (candidates (nconc
                      (mapcar (lambda (ov)
                                (cons (overlay-start ov)
                                      (overlay-get ov 'window)))
                              overlays-for-avy)
                      (with-current-buffer vterm-posframe-buffer
                        (save-excursion
                          (save-restriction
                            (narrow-to-region (window-start window)
                                              (window-end window))
                            (goto-char (point-min))
                            (forward-line)
                            (let (cands)
                              (while (not (eobp))
                                (push (cons (+ (point) offset) window)
                                      cands)
                                (forward-line))
                              cands)))))))
    (unwind-protect
        (prog2
            (avy--make-backgrounds
             (append (avy-window-list)
                     (list (vterm-state-window ivy-last))))
            (if (eq avy-style 'de-bruijn)
                (avy-read-de-bruijn candidates avy-keys)
              (avy-read (avy-tree candidates avy-keys)
                        #'avy--overlay-post
                        #'avy--remove-leading-chars))
          (avy-push-mark))
      (avy--done))))

(declare-function avy-action-goto "avy")
(declare-function avy-candidate-beg "avy")
(defun vterm-posframe-swiper-avy ()
  "Jump to one of the current swiper candidates."
  (interactive)
  (if (not (string-match-p "^vterm-posframe-display"
                           (symbol-name vterm--display-function)))
      ;; if swiper is not use vterm-posframe's display function.
      ;; call `swiper-avy'.

      ;; FIXME: This assume all vterm-posframe display functions are
      ;; prefixed with vterm-posframe-display.
      (swiper-avy)
    (unless (require 'avy nil 'noerror)
      (error "Package avy isn't installed"))
    (unless (require 'avy nil 'noerror)
      (error "Package avy isn't installed"))
    (cl-case (length vterm-text)
      (0
       (user-error "Need at least one char of input"))
      (1
       (let ((swiper-min-highlight 1))
         (swiper--update-input-vterm))))
    (unless (string= vterm-text "")
      (let ((candidate (vterm-posframe--swiper-avy-candidate)))
        (cond ((eq (cdr candidate) (vterm-posframe--window))
               (let ((cand-text (with-current-buffer vterm-posframe-buffer
                                  (save-excursion
                                    (goto-char (car candidate))
                                    (buffer-substring
                                     (line-beginning-position)
                                     (line-end-position))))))
                 (vterm-set-index
                  ;; cand-text may include "> ", using a hack way
                  ;; to deal with it.
                  (or (cl-some (lambda (n)
                                 (cl-position (substring cand-text n) vterm--old-cands :test #'string=))
                               '(0 1 2 3 4))
                      0))
                 (vterm--exhibit)
                 (vterm-done)
                 (vterm-call)))
              ((or (consp candidate)
                   (number-or-marker-p candidate))
               (vterm-quit-and-run
                 (avy-action-goto (avy-candidate-beg candidate)))))))))

;;; Variables

(defvar vterm-posframe-advice-alist
  '((vterm--minibuffer-setup      . ivy-posframe--minibuffer-setup)
    (vterm--display-function-prop . ivy-posframe--display-function-prop)
    (vterm--height                . ivy-posframe--height)
    (vterm-read                   . ivy-posframe--read)))

;;; Advice

(defun vterm-posframe--minibuffer-setup (fn &rest args)
  "Advice function of FN, `vterm--minibuffer-setup' with ARGS."
  (if (not (display-graphic-p))
      (apply fn args)
    (let ((vterm-fixed-height-minibuffer nil))
      (apply fn args))
    (when (and vterm-posframe-hide-minibuffer
               (posframe-workable-p)
               ;; if display-function is not a vterm-posframe style display-function.
               ;; do not hide minibuffer.
               ;; The hypothesis is that all vterm-posframe style display functions
               ;; have vterm-posframe as name prefix, need improve!
               (string-match-p "^vterm-posframe" (symbol-name ivy--display-function)))
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'vterm-posframe t)
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil)))))

(defun vterm-posframe--add-prompt (fn &rest args)
  "Add the vterm prompt to the posframe.  Advice FN with ARGS."
  (apply fn args)
  (when (and (display-graphic-p)
             (not vterm-posframe--ignore-prompt))
    (with-current-buffer (window-buffer (active-minibuffer-window))
      (let ((point (point))
            (prompt (buffer-string)))
        (remove-text-properties 0 (length prompt) '(read-only nil) prompt)
        (with-current-buffer vterm-posframe-buffer
          (goto-char (point-min))
          (delete-region (point) (line-beginning-position 2))
          (insert prompt "  \n")
          (add-text-properties point (1+ point) '(face vterm-posframe-cursor)))))))

(defun vterm-posframe--display-function-prop (fn &rest args)
  "Around advice of FN with ARGS."
  (if (not (display-graphic-p))
      (apply fn args)
    (let ((vterm-display-functions-props
           (append vterm-display-functions-props
                   (mapcar
                    (lambda (elm)
                      `(,elm :cleanup vterm-posframe-cleanup))
                    (mapcar #'cdr vterm-posframe-display-functions-alist)))))
      (apply fn args))))

(defun vterm-posframe--height (fn &rest args)
  "Around advide of FN with ARGS."
  (if (not (display-graphic-p))
      (apply fn args)
    (let ((vterm-height-alist
           (append vterm-posframe-height-alist ivy-height-alist)))
      (apply fn args))))

(defun vterm-posframe--read (fn &rest args)
  "Around advice of FN with AGS."
  (if (not (display-graphic-p))
      (apply fn args)
    (let ((vterm-display-functions-alist
           (append vterm-posframe-display-functions-alist ivy-display-functions-alist)))
      (apply fn args))))

;;;###autoload
(define-minor-mode vterm-posframe-mode
  "Display vterm via posframe."
  :init-value nil
  :global t
  :require 'vterm-posframe
  :lighter vterm-posframe-lighter
  :group 'vterm-posframe
  :keymap '(([remap vterm-avy]              . ivy-posframe-avy)
            ([remap swiper-avy]           . vterm-posframe-swiper-avy)
            ([remap vterm-read-action]      . ivy-posframe-read-action)
            ([remap vterm-dispatching-done] . ivy-posframe-dispatching-done))
  (if vterm-posframe-mode
      (mapc (lambda (elm)
              (advice-add (car elm) :around (cdr elm)))
            vterm-posframe-advice-alist)
    (mapc (lambda (elm)
            (advice-remove (car elm) (cdr elm)))
          vterm-posframe-advice-alist)))

;;;###autoload
(defun vterm-posframe-enable ()
  (interactive)
  (vterm-posframe-mode 1)
  (message "vterm-posframe: suggest use `ivy-posframe-mode' instead."))

(provide 'vterm-posframe)
