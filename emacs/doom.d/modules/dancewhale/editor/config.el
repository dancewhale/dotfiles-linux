;;; dancewhale/editor/config.el -*- lexical-binding: t; -*-
;;;
;;;
;;; evil docs  https://github.com/noctuid/evil-guide
;;;


;; 在insert mode C-y 快捷键粘贴
;; :i 和 evil-insert-state-mode 冲突
(map! (:desc "paste before curse in insert mode."
       :i "C-y" #'evil-paste-before)
      (:desc "complete use helm-complete"
       :i "C-n" #'helm-lisp-completion-at-point))

;; 退出自动保存
(add-hook 'evil-insert-state-exit-hook
	  (lambda ()
	    (if (string-equal major-mode "org-mode")
		(call-interactively #'save-buffer))))
