(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/gtd"))
(set-language-environment "UTF-8")
(setq org-todo-keywords '((sequence "TODO" "DOING" "DONE" "DELAY" "ABORT")))
(setq org-todo-keyword-faces '(
			       ("DOING" . "pink")
			       ("DONE"  . "orange")
			       ("ABORT" . "grey")
			       ("DELAY" . "purple")
			       ))


(defun VainJoker/open-gtd-file()
  "Open ~/org/GTD.org file"
  (interactive)
  (find-file "~/org/gtd/gtd.org"))


(setq org-capture-templates nil)
(add-to-list 'org-capture-templates
	     '("h" "Homework" entry
	       (file+headline "~/org/gtd/homework.org" "Homework")
	       "* TODO [#B] %^{heading}\n%u\n ?\n" :clock-in t :clock-resume t))
(add-to-list 'org-capture-templates
	     '("b" "Billing" plain
	       (file+function "~/org/gtd/billing.org" find-month-tree)
	       " | %U | %^{类别} | %^{描述} | %^{金额} |" :kill-buffer t))
(add-to-list 'org-capture-templates
	     '("i" "Inbox" entry (file "~/org/gtd/inbox.org")
	       "* %U - %^{heading} %^g\n %?\n"))
(add-to-list 'org-capture-templates
	     '("s" "Someday" entry (file "~/org/gtd/someday.org")
	       "* %U - %^{heading} %^g\n %?\n"))
(add-to-list 'org-capture-templates
	     '("j" "Journal" entry (file "~/org/gtd/journal.org")
	       "* %U - %^{heading} %^g\n %?\n"))
(add-to-list 'org-capture-templates
	     '("t" "Todo" entry (file "~/org/gtd/todo.org")
	       "* TODO [#B] %U - %^{heading} %^g\n %?\n"))

(setq org-highest-priority ?A)
(setq org-lowest-priority  ?C)
(setq org-default-priority ?B)

(defun get-year-and-month ()
  (list (format-time-string "%Y年") (format-time-string "%m月")))

(defun find-month-tree ()
  (let* ((path (get-year-and-month))
	 (level 1)
	 end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
			(regexp-quote heading)))
	    (cnt 0))
	(if (re-search-forward re end t)
	    (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
	  (progn                        ;否则就新建一个 headline
	    (or (bolp) (insert "\n"))
	    (if (/= (point) (point-min)) (org-end-of-subtree t t))
	    (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))

(use-package ox-reveal
             :ensure t
	     :defer 2
             :after org
             :config
             (reveal-mode 1)
             (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
             )

(use-package ob-go
  :ensure t
  )

;; (org-babel-do-load-languages
;;   'org-babel-load-languages
;;   '((python . t)
;;     (C . t)
;;     (go . t)
;;     (emacs-lisp . t)
;;     (shell . t)))

(use-package org-superstar              ; supersedes `org-bullets'
  :ensure t
  :defer 2
  :after org
  :hook
  (org-mode-hook . org-superstar-mode-hook)
  :config
  (setq org-superstar-remove-leading-stars t)
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  )

(use-package org-roam
  :defer 2
  ;; :ensure t
  :after org
  :custom
  ;; (org-roam-mode 1)
  (org-roam-directory "~/org-roam")
  :bind (:map org-roam-mode-map
	      (("C-c n l" . org-roam)
	       ("C-c n f" . org-roam-find-file)
	       ("C-c n g" . org-roam-show-graph))
	      ("C-c n i" . org-roam-insert)))

(use-package org2ctex
  :defer 5
  :config
  (org2ctex-toggle 1)
  )

(use-package org-pomodoro
  :ensure t
  :defer 2
  :config 
  (setq org-pomodoro-length 40)
  (setq org-pomodoro-finished-sound-p nil)
  (setq org-pomodoro-long-break-sound-p nil)
  (setq org-pomodoro-overtime-sound-p nil)
  (setq org-pomodoro-short-break-sound-p nil)
  (setq org-pomodoro-start-sound-p nil)
  (add-hook 'org-pomodoro-finished-hook
	    (lambda ()
	      (call-process-shell-command "notify-send -u critical 您要休息一下了!" )))
  )


					; (after! org-mode
					;         (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
					;         )
					; (after! latex-mode
					;         (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex))
(use-package ox-pandoc
  :defer 2
  :ensure t
  )

(use-package cal-china-x
  :after calendar
  :defer 2
  :ensure t
  )

(setq my-holidays
      '(;;公历节日
	(holiday-fixed 1 1 "元旦节")
	(holiday-fixed 5 1 "劳动节")
	(holiday-fixed 10 1 "国庆节")
	;; 农历节日
	(holiday-lunar 1 1 "春节" 0)
	(holiday-lunar 1 15 "元宵节" 0)
	(holiday-solar-term "清明" "清明节")
	(holiday-lunar 5 5 "端午节" 0)
	(holiday-lunar 7 7 "七夕情人节" 0)
	(holiday-lunar 8 15 "中秋节" 0)
	;;纪念日
	(holiday-fixed 12 28 "我的生日")
	))
(setq calendar-mark-diary-entries-flag t)
(setq calendar-mark-holidays-flag t)
(setq calendar-holidays my-holidays)  ;只显示我定制的节假日

(setq org-superstar-headline-bullets-list
  '("☯" "✿" "✚" "◉" "❀")
  )
  ;; '(;; Original ones nicked from org-bullets
  ;;   "◉"
  ;;   "○"
  ;;   "✸"
  ;;   "✿") ;; "◉" "🞛" "○" "▷"
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING|HOLD/!"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil))))



(provide 'init-org)

