;;; dancewhale/editor/config.el -*- lexical-binding: t; -*-
;;;
;;;
;;; evil docs  https://github.com/noctuid/evil-guide
;;;


;; 在insert mode C-y 快捷键粘贴
(define-key evil-insert-state-map "\C-y" 'evil-paste-before)

;; 退出自动保存
(add-hook 'evil-insert-state-exit-hook
	  (lambda ()
	    (if (string-equal major-mode "org-mode")
		(call-interactively #'save-buffer))))

;; 开启helm-complete
(define-key evil-insert-state-map (kbd "C-n") #'helm-lisp-completion-at-point)
