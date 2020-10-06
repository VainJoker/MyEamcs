(use-package autoinsert
  :ensure nil
  :hook (prog-mode . auto-insert-mode)
  :config
  (defun maple/insert-string(&optional prefix)
    (replace-regexp-in-string
     "^" (or prefix comment-start)
     (concat
      (make-string 80 ?*) "\n"
      "Copyright © " (substring (current-time-string) -4) " " (user-full-name) "\n"
      "File Name: " (file-name-nondirectory buffer-file-name) "\n"
      "Author: " (user-full-name)"\n"
      "Email: " user-mail-address "\n"
      "Created: " (format-time-string "%Y-%m-%d %T (%Z)" (current-time)) "\n"
      "Last Update: \n"
      "         By: \n"
      "Description: \n"
      (make-string 80 ?*))))

  (setq auto-insert-query nil
        auto-insert-alist
        '(((ruby-mode . "Ruby program") nil
           "#!/usr/bin/env ruby\n"
           "# -*- encoding: utf-8 -*-\n"
           (maple/insert-string) "\n")
          ((python-mode . "Python program") nil
           "#!/usr/bin/env python\n"
           "# -*- coding: utf-8 -*-\n"
           (maple/insert-string) "\n")
          ((c-mode . "C program") nil
           "/*"
           (string-trim-left (maple/insert-string " ")) "*/\n"
           "#include<stdio.h>\n"
           "#include<string.h>\n")
          ((sh-mode . "Shell script") nil
           "#!/bin/bash\n"
           (maple/insert-string) "\n")
          ((go-mode . "Go program") nil
           "/*"
           (string-trim-left (maple/insert-string " ")) "*/\n")
          ((rust-mode . "Rust program") nil
           "/*"
           (string-trim-left (maple/insert-string " ")) "*/\n")
          )))

(use-package maple-header
  :ensure nil
  :defines (maple-header-email-p maple-header-filename-p)
  :hook (maple-init . maple-header-mode)
  :config
  (setq maple-header-filename-p t
        maple-header-email-p nil))

;; ;;首先这句话设置一个目录，你的auto-insert 的模版文件会存放在这个目录中，
;; (setq-default auto-insert-directory "~/.emacs.d/var/auto-insert/")
;; (auto-insert-mode)  ;;; 启用auto-insert
;; ;; 默认情况下插入模版前会循问你要不要自动插入，这里设置为不必询问，
;; ;; 在新建一个org文件时，自动插入`auto-insert-directory'目录下的`org-auto-insert`文件中的内容
;; (setq auto-insert-query nil)
;; (define-auto-insert "\\.org" "org-auto-insert")
;; ;;这个就是新建以.c 结尾的C文件时，会自动插入c-auto-insert文件中的内容
;; (define-auto-insert "\\.c" "c-auto-insert")
;; (define-auto-insert "\\.go" "go-auto-insert")

(provide 'init-autoinsert)
