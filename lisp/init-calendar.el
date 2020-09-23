;; Chinese calendar
;; `pC' can show lunar details
(use-package cal-china-x
  :after calendar
  :commands cal-china-x-setup
  :init (cal-china-x-setup)
  :config
  ;; Holidays
  (setq calendar-mark-holidays-flag t
        cal-china-x-important-holidays cal-china-x-chinese-holidays
        cal-china-x-general-holidays '((holiday-lunar 1 15 "元宵节")
                                       (holiday-lunar 7 7 "七夕节")
                                       (holiday-fixed 3 8 "妇女节")
                                       (holiday-fixed 3 12 "植树节")
                                       (holiday-fixed 5 4 "青年节")
                                       (holiday-fixed 6 1 "儿童节")
                                       (holiday-fixed 9 10 "教师节"))
        holiday-other-holidays '((holiday-fixed 2 14 "情人节")
                                 (holiday-fixed 4 1 "愚人节")
                                 (holiday-fixed 12 25 "圣诞节")
                                 (holiday-float 5 0 2 "母亲节")
                                 (holiday-float 6 0 3 "父亲节")
                                 (holiday-float 11 4 4 "感恩节"))
        calendar-holidays (append cal-china-x-important-holidays
                                  cal-china-x-general-holidays
                                  holiday-other-holidays))

                                        ; (setq my-holidays
                                        ;       '(;;公历节日
                                        ;     (holiday-fixed 1 1 "元旦节")
                                        ;     (holiday-fixed 5 1 "劳动节")
                                        ;     (holiday-fixed 10 1 "国庆节")
                                        ;     ;; 农历节日
                                        ;     (holiday-lunar 1 1 "春节" 0)
                                        ;     (holiday-lunar 1 15 "元宵节" 0)
                                        ;     (holiday-solar-term "清明" "清明节")
                                        ;     (holiday-lunar 5 5 "端午节" 0)
                                        ;     (holiday-lunar 7 7 "七夕情人节" 0)
                                        ;     (holiday-lunar 8 15 "中秋节" 0)
                                        ;     ;;纪念日
                                        ;     (holiday-fixed 12 28 "我的生日")
                                        ;     ))
                                        ; ;; (setq calendar-mark-diary-entries-flag t)
                                        ; (setq calendar-mark-holidays-flag t)
                                        ; (setq calendar-holidays my-holidays)  ;只显示我定制的节假日
                                        ;
  )

(setq org-agenda-include-diary t)
(setq org-agenda-diary-file "~/org/gtd/diary")
(setq diary-file "~/org/gtd/diary")
(setq calendar-latitude 31.57) ;;lat, flat
(setq calendar-longitude 120.29) ;;long是经度
(setq org-agenda-time-grid (quote ((daily today require-timed)
                                   (300
                                    600
                                    900
                                    1200
                                    1500
                                    1800
                                    2100
                                    2400)
                                   "......"
                                   "-----------------------------------------------------"
                                   ))
      )

;;Sunrise and Sunset
;;日出而作, 日落而息
(defun diary-sunrise ()
  (let ((dss (diary-sunrise-sunset)))
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ",")
      (buffer-substring (point-min) (match-beginning 0)))))

(defun diary-sunset ()
  (let ((dss (diary-sunrise-sunset))
        start end)
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ", ")
      (setq start (match-end 0))
      (search-forward " at")
      (setq end (match-beginning 0))
      (goto-char start)
      (capitalize-word 1)
      (buffer-substring start end))))

;; Better views of calendar
(use-package calfw
  :commands cfw:open-calendar-buffer
  :bind ("<C-f12>" . open-calendar)
  :init
  (use-package calfw-org
    :commands (cfw:open-org-calendar cfw:org-create-source))

  (use-package calfw-ical
    :commands (cfw:open-ical-calendar cfw:ical-create-source))

  (defun open-calendar ()
    "Open calendar."
    (interactive)
    (unless (ignore-errors
              (cfw:open-calendar-buffer
               :contents-sources
               (list
                (when org-agenda-files
                  (cfw:org-create-source "YellowGreen"))
                (when (bound-and-true-p centaur-ical)
                  (cfw:ical-create-source "gcal" centaur-ical "IndianRed")))))
      (cfw:open-calendar-buffer)))
  (defalias 'centaur-open-calendar #'open-calendar))

(provide 'init-calendar)
