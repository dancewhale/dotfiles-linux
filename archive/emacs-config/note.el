;;; ~/my/emacs_conf/cao_emacs.d/doom.d/archive/note.el -*- lexical-binding: t; -*-
;;;
;;;;-------------------------------------------------
;;; zetteldeft 配置
;;;-------------------------------------------------

(package! zetteldeft
  :recipe (:host github :repo "EFLS/zetteldeft" :files ("zetteldeft.el")))

;;;防止doom默认配置下zettel-new-file出现双标题.
(set-file-template! 'org-mode :ignore t)
(require 'zetteldeft)
(setq deft-use-filter-string-for-filename nil)

; zetteldeft的快捷键配置
(global-set-key (kbd "C-c d d") 'deft)
(global-set-key (kbd "C-c d D") 'zetteldeft-deft-new-search)
(global-set-key (kbd "C-c d R") 'deft-refresh)
(global-set-key (kbd "C-c d s") 'zetteldeft-search-at-point)
(global-set-key (kbd "C-c d c") 'zetteldeft-search-current-id)
(global-set-key (kbd "C-c d f") 'zetteldeft-follow-link)
(global-set-key (kbd "C-c d F") 'zetteldeft-avy-file-search-ace-window)
(global-set-key (kbd "C-c d l") 'zetteldeft-avy-link-search)
(global-set-key (kbd "C-c d t") 'zetteldeft-avy-tag-search)
(global-set-key (kbd "C-c d T") 'zetteldeft-tag-buffer)
(global-set-key (kbd "C-c d i") 'zetteldeft-find-file-id-insert)
(global-set-key (kbd "C-c d I") 'zetteldeft-find-file-full-title-insert)
(global-set-key (kbd "C-c d o") 'zetteldeft-find-file)
(global-set-key (kbd "C-c d n") 'zetteldeft-new-file)
(global-set-key (kbd "C-c d N") 'zetteldeft-new-file-and-link)
(global-set-key (kbd "C-c d r") 'zetteldeft-file-rename)
(global-set-key (kbd "C-c d x") 'zetteldeft-count-words)


;;;-------------------------------------------------
;; org-editor启动
;;;-------------------------------------------------
(package! anki-editor
  :recipe (:host github :repo "louietan/anki-editor" :branch "master"))

(require 'anki-editor)
