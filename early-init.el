(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 200))
(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
(run-with-idle-timer 5 nil (lambda () 
                             (setq gc-cons-threshold gc-cons-threshold-original) 
                             (setq file-name-handler-alist file-name-handler-alist-original) 
                             (makunbound 'gc-cons-threshold-original) 
                             (makunbound 'file-name-handler-alist-original)
			     ))
(add-hook 'emacs-startup-hook
    (lambda ()
        (message "Emacs ready in %s with %d garbage collections."
            (format "%.2f seconds"
                (float-time
                    (time-subtract after-init-time before-init-time)))
        gcs-done)))
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq  initial-scratch-message "                                                            Happy Hacking , VainJoker \n ")
;; yes-or-no-p to y-or-n-p
(fset 'yes-or-no-p 'y-or-n-p)
;; 关闭GUI功能
(setq use-file-dialog nil use-dialog-box nil inhibit-startup-screen t inhibit-startup-message t)
;; 关闭备份
(setq make-backup-files nil auto-save-default nil)
;; 默认垂直分屏
(setq split-width-threshold nil)
;; 关闭锁文件
(setq create-lockfiles nil)
;; 总是加载最新的文件
(setq load-prefer-newer t)
;; 关闭字体缓存gc
(setq inhibit-compacting-font-caches nil)
;; 关闭烦人的提示
(setq ring-bell-function 'ignore blink-cursor-mode nil)
;; 任何地方都使用UTF-8
(set-charset-priority 'unicode) 
(setq locale-coding-system   'utf-8)    ; pretty
(set-terminal-coding-system  'utf-8)    ; pretty
(set-keyboard-coding-system  'utf-8)    ; pretty
(set-selection-coding-system 'utf-8)    ; please
(prefer-coding-system        'utf-8)    ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
;; 更友好和平滑的滚动
(setq scroll-step 2
  scroll-margin 2
  hscroll-step 2
  hscroll-margin 2
  scroll-conservatively 101
  scroll-up-aggressively 0.01
  scroll-down-aggressively 0.01
  scroll-preserve-screen-position 'always)
;; 关闭自动调节行高
(setq auto-window-vscroll nil)
;; 显示行号
;; (global-linum-mode 1)
;; (setq display-line-numbers-type 'relative)
;; (global-display-line-numbers-mode 1)
;; 设置光标样式
(setq-default cursor-type 'bar)
;; 去除默认启动界面
(setq inhibit-startup-message t)
;; 创建新行的动作
(global-set-key (kbd "RET") 'newline-and-indent) 
(global-set-key (kbd "S-<return>") 'comment-indent-new-line)
;; 让光标无法离开视线
(setq mouse-yank-at-point nil)
; ;; 让'_'被视为单词的一部分
; (add-hook 'after-change-major-mode-hook (lambda ()
;                                           (modify-syntax-entry ?_ "w")))
; ;; "-" 同上)
; (add-hook 'after-change-major-mode-hook (lambda ()
;                                           (modify-syntax-entry ?- "w")))
