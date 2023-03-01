;;; /opt/cao-emacs/doom.d/archive/chinese.el -*- lexical-binding: t; -*-

;;---------------------------------------
;; liberime中文输入法设置
;;---------------------------------------
(setq rime-path (concat envpath "/libForBuild/lib"))
(setq liberime-user-data-dir  (concat envpath "/rime/"))
(setq load-path (cons rime-path load-path))
(add-load-path! (file-truename "~/.emacs.d/.local/straight/repos/liberime"))
(require 'liberime-core)
(require 'liberime)

(setq default-input-method "pyim")
(setq pyim-page-tooltip 'posframe)
(setq pyim-page-length 9)

(liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" rime-path)
(liberime-select-schema "luna_pinyin_simp")
(setq pyim-default-scheme 'rime-quanpin)

;;自动切换中英文，注释和正文中不输入中文。
(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))

(setq-default pyim-punctuation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))

;;强制转换英文为中文，与 pyim-probe-dynamic-english 配合
(global-set-key (kbd "s-j") 'pyim-convert-string-at-point)


;;;-------------------------------------------------
;; rime input-method
;; rime的输入法在doom中的配置的编译失败可以手工介入
;; 在repos中的emacs-rime目录中执行make lib后
;; 把编译好的so和.c文件放入build/rime目录之下。
;;;-------------------------------------------------
(package! rime
 :recipe(:host github :repo "DogLooksGood/emacs-rime"
         :files ("rime-predicates.el" "rime.el" "lib.c" "Makefile")))

(require 'rime)

(setq rime-translate-keybindings
  '("C-f" "C-b" "C-n" "C-p" "C-g" "C-h" "<left>" "<tab>"
    "<right>" "<up>" "<down>" "<prior>" "<next>" "<delete>"))

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :font system_font
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

(setq rime-user-data-dir (file-truename "~/.config/rime"))
(setq rime-librime-root (file-truename "~/Dropbox/emacs/lib/librime/"))
(setq rime-emacs-module-header-root
      (file-truename "/Applications/Emacs.app/Contents/Resources/include/"))

;; evil-escape  jk推出
 (defun rime-evil-escape-advice (orig-fun key)
   "advice for `rime-input-method' to make it work together with `evil-escape'.
	Mainly modified from `evil-escape-pre-command-hook'"
   (if rime--preedit-overlay
	;; if `rime--preedit-overlay' is non-nil, then we are editing something, do not abort
	(apply orig-fun (list key))
     (when (featurep 'evil-escape)
	(let* (
	       (fkey (elt evil-escape-key-sequence 0))
	       (skey (elt evil-escape-key-sequence 1))
	       (evt (read-event nil nil evil-escape-delay))
	       )
	  (cond
	   ((and (characterp evt)
		 (or (and (char-equal key fkey) (char-equal evt skey))
		     (and evil-escape-unordered-key-sequence
			  (char-equal key skey) (char-equal evt fkey))))
	    (evil-repeat-stop)
	    (evil-normal-state))
	   ((null evt) (apply orig-fun (list key)))
	   (t
	    (apply orig-fun (list key))
	    (if (numberp evt)
		(apply orig-fun (list evt))
	      (setq unread-command-events (append unread-command-events (list evt))))))))))

(advice-add 'rime-input-method :around #'rime-evil-escape-advice)

(global-set-key (kbd "s-j") 'toggle-input-method)
