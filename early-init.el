(add-to-list 'default-frame-alist '(fullscreen . maximized))
(push '(font . "Iosevka-14") default-frame-alist)
(setq  initial-scratch-message "                                                                Happy Hacking , VainJoker \n ")
;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)
(setq package-enable-at-startup nil)
;; (setq frame-inhibit-implied-resize t)
;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))
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
;; 让光标无法离开视线
(setq mouse-yank-at-point nil)
