(use-package org
  :ensure nil
  :custom-face (org-ellipsis ((t (:foreground nil))))
  :preface
  (defun hot-expand (str &optional mod)
    (let (text)
      (when (region-active-p)
        (setq text (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
      (insert str)
      (if (fboundp 'org-try-structure-completion)
          (org-try-structure-completion) ; < org 9
        (progn
          (require 'org-tempo nil t)
          (org-tempo-complete-tag)))
      (when mod (insert mod) (forward-line))
      (when text (insert text))))
  :hook (((org-babel-after-execute org-mode) . org-redisplay-inline-images) ; display image
         (org-mode . (lambda ()
                       (prettify-symbols-mode 1)))
         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  :config
  (setq org-tags-column -80
        org-log-done 'time
        org-catch-invisible-edits 'smart
        org-startup-indented t
        ;; org-ellipsis (if (char-displayable-p ?⏷) "\t⏷" nil)
        org-pretty-entities nil
        org-hide-emphasis-markers t)


  (setq org-directory "~/org/")
  (setq org-agenda-files '("~/org/gtd"))
  (set-language-environment "UTF-8")
  (setq org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")(sequence "⚑(T)" "🏴(I)" "(H)" "|" "✔(D)" "✘(C)")))
  (setq org-todo-keyword-faces '(
                                 ("DOING" . "pink")
                                 ("DONE"  . "orange")
                                 ("CANCEL" . "grey")
                                 ("HANGUP" . "purple")
                                 ))
  (defun VainJoker/open-gtd-file()
    "Open ~/org/GTD.org file"
    (interactive)
    (find-file "~/org/gtd/gtd.org"))
  (setq org-capture-templates nil)
  (add-to-list 'org-capture-templates
               '("h" "Homework" entry
                 (file+headline "~/org/gtd/homework.org" "Homework")
                 "* TODO [#B] %^{heading}\n%u\n %^{detail}\n" :clock-in t :clock-resume t))
  (add-to-list 'org-capture-templates
               '("b" "Billing" plain
                 (file+function "~/org/gtd/billing.org" find-month-tree)
                 " | %U | %^{category} | %^{describe} | %^{money} |" :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("i" "Inbox" entry (file "~/org/gtd/inbox.org")
                 "* %U - %^{heading} %^g\n %^{detail}\n"))
  (add-to-list 'org-capture-templates
               '("s" "Someday" entry (file "~/org/gtd/someday.org")
                 "* %U - %^{heading} %^g\n %^{detail}\n"))
  (add-to-list 'org-capture-templates
               '("j" "Journal" entry (file "~/org/gtd/journal.org")
                 "* %U - %^{heading} %^g\n %^{detail}\n"))
  (add-to-list 'org-capture-templates
               '("t" "Todo" entry (file "~/org/gtd/todo.org")
                 "* TODO [#B] %U - %^{heading} %^g\n %^{detail}\n"))

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


  (setq org-highest-priority ?A)
  (setq org-lowest-priority  ?C)
  (setq org-default-priority ?B)

  ;;  Babel
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)

  (defvar load-language-list '((emacs-lisp . t)
                               (perl . t)
                               (python . t)
                               (ruby . t)
                               (js . t)
                               (css . t)
                               (sass . t)
                               (C . t)
                               (java . t)
                               (plantuml . t)))

  (cl-pushnew '(shell . t) load-language-list)

  (use-package ob-go
    :init (cl-pushnew '(go . t) load-language-list))

  (use-package ob-rust
    :init (cl-pushnew '(rust . t) load-language-list))

  (use-package ob-ipython
    :if (executable-find "jupyter")     ; DO NOT remove
    :init (cl-pushnew '(ipython . t) load-language-list))

  ;; Use mermadi-cli: npm install -g @mermaid-js/mermaid-cli
  (use-package ob-mermaid
    :init (cl-pushnew '(mermaid . t) load-language-list))

  (org-babel-do-load-languages 'org-babel-load-languages
                               load-language-list)

  ;; org-roam
  (when (executable-find "cc")
    (use-package org-roam
      :diminish
      :custom (org-roam-directory "~/org/org-roam")
      :hook (after-init . org-roam-mode)
      :bind (:map org-roam-mode-map
             (("C-c n l" . org-roam)
              ("C-c n f" . org-roam-find-file)
              ("C-c n g" . org-roam-graph))
             :map org-mode-map
             (("C-c n i" . org-roam-insert))
             (("C-c n I" . org-roam-insert-immediate))))

    (use-package org-roam-server
      :functions xwidget-buffer xwidget-webkit-current-session
      :hook (org-roam-server-mode . org-roam-server-browse)
      :init
      (defun org-roam-server-browse ()
        (when org-roam-server-mode
          (let ((url (format "http://%s:%d" org-roam-server-host org-roam-server-port)))
            (if (featurep 'xwidget-internal)
                (progn
                  (xwidget-webkit-browse-url url)
                  (let ((buf (xwidget-buffer (xwidget-webkit-current-session))))
                    (when (buffer-live-p buf)
                      (and (eq buf (current-buffer)) (quit-window))
                      (pop-to-buffer buf))))
              (browse-url url)))))))


  (use-package ox-reveal
    :hook (org-reveal . org-mode)
    :config
    (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
    )

  (use-package org-superstar              ; supersedes `org-bullets'
    :hook
    (org-mode . org-superstar-mode)
    :config
    (setq org-superstar-headline-bullets-list
          '("☯" "❀" "✿" "✚" "◉" "▷"  )
          )
    (setq org-superstar-remove-leading-stars t)
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
    (setq org-superstar-configure-like-org-bullets 1)
    )
  (use-package org2ctex
    :after org
    :defer 5
    )
  (use-package org-pomodoro
    :config
    (setq org-pomodoro-length 40)
    (setq org-pomodoro-finished-sound-p nil)
    (setq org-pomodoro-long-break-sound-p nil)
    (setq org-pomodoro-overtime-sound-p nil)
    (setq org-pomodoro-short-break-sound-p nil)
    (setq org-pomodoro-start-sound-p nil)
    (setq org-pomodoro-long-break-length 10)
    (add-hook 'org-pomodoro-finished-hook
              (lambda ()
                (call-process-shell-command "notify-send -u critical 您要休息一下了!" )))
    )

  (use-package ox-pandoc
    :demand t
    :after ox
    )

  (use-package valign
    :demand t
    :load-path "~/.emacs.d/site-lisp/valign"
    )

  )


(provide 'init-org)
