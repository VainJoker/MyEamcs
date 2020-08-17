(setq gnus-secondary-select-methods '((nnml ""))) 
(setq gnus-select-method
      '(nnimap "163.com"
	       (nnimap-address "imap.163.com")
	       (nnimap-inbox "INBOX")
	       (nnimap-expunge t)
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

(setq send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.163.com"
      smtpmail-smtp-service 994
      smtpmail-stream-type 'ssl
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")


(cond (window-system
       (setq custom-background-mode 'light)
       (defface my-group-face-1
	 '((t (:foreground "Red" :bold t))) "First group face")
       (defface my-group-face-2
	 '((t (:foreground "DarkSeaGreen4" :bold t)))
	 "Second group face")
       (defface my-group-face-3
	 '((t (:foreground "Green4" :bold t))) "Third group face")
       (defface my-group-face-4
	 '((t (:foreground "Gray" :bold t))) "Fourth group face")
       (defface my-group-face-5
	 '((t (:foreground "LightBlue" :bold t))) "Fifth group face")))

(setq gnus-group-highlight
      '(((> unread 200) . my-group-face-1)
	((and (< level 3) (zerop unread)) . my-group-face-2)
	((< level 3) . my-group-face-3)
	((zerop unread) . my-group-face-4)
	(t . my-group-face-5)))

;;2.18.3 Group Timestamp
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
;;(setq gnus-group-line-format
;;"%M%S%p%P%5y: %(%-40,40g%) %6,6~(cut 2)dn")

;; (setq gnus-group-line-format
;;       "%M%S%p%P%5y: %(%-40,40g%) %udn")
;; (defun gnus-user-format-function-d (headers)
;;   (let ((time (gnus-group-timestamp gnus-tmp-group)))
;;     (if time
;;         (format-time-string "%b %d  %H:%M" time)
;;       "")))

;;3.6 Delayed Articles
(gnus-delay-initialize)


;;3.10 Sorting the Summary Buffer
(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-number)
	gnus-thread-sort-by-score))

;;3.11 Asynchronous Article Fetching
(setq gnus-asynchronous t)
;;pre-fetch only unread articles shorter than 100 lines, you could say something like:
(defun my-async-short-unread-p (data)
  "Return non-nil for short, unread articles."
  (and (gnus-data-unread-p data)
       (< (mail-header-lines (gnus-data-header data))
	  100)))
(setq gnus-async-prefetch-article-p 'my-async-short-unread-p)

;;3.13 Persistent Articles
(setq gnus-use-cache 'passive)

;; 3.25 Tree Display
(setq gnus-use-trees nil)
;; (setq gnus-use-trees t
;;       gnus-generate-tree-function 'gnus-generate-horizontal-tree
;;       gnus-tree-minimize-window nil)
;; (gnus-add-configuration
;;  '(article
;;    (vertical 1.0
;;              (horizontal 0.25
;;                          (summary 0.75 point)
;;                          (tree 1.0))
;;              (article 1.0))))


;;4.3 HTML
(setq gnus-blocked-images "ads")

;;5.4 Mail and Post
(add-hook 'message-send-hook 'ispell-message)

;;5.5 Archived Messages
(setq gnus-message-archive-group nil)


;;6.4.9 Expiring Mail
(remove-hook 'gnus-mark-article-hook              'gnus-summary-mark-read-and-unread-as-read)
(add-hook 'gnus-mark-article-hook 'gnus-summary-mark-unread-as-read)
;; Delele mail
(setq nnmail-expiry-wait 'never)
(setq nnmail-expiry-target "Deleted Messages")

;;9.5 Window Layout
(setq gnus-use-full-window nil)
;;((group (vertical 1.0 (group 1.0 point)))
;; (article (vertical 1.0 (summary 0.25 point)
;;                    (article 1.0))))

;; (gnus-configure-frame
;;  '(frame 1.0
;;          (vertical 1.0
;;                    (summary 0.25 point frame-focus)
;;                    (article 1.0))
;;          (vertical ((height . 5) (width . 15)
;;                     (user-position . t)
;;                     (left . -1) (top . 1))
;;                    (picon 1.0))))

(defun gnus-other-window()
  (interactive)
  (split-window-right)
  (gnus)
  )

(provide 'init-mail)
