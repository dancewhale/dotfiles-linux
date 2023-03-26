;;; dancewhale/chinese/config.el -*- lexical-binding: t; -*-

;; +rime 使用liberime
;; TODO: pyim 支持非rime 模式的普通输入法

;; 中文输入法配置
(setq fcitx5-rime-user-date-dir (file-truename "~/.local/share/fcitx5/rime"))


;; chinese input  rime-liberime + ice_rime
(use-package! liberime
  :when (modulep! +rime)
  :config
  (setq liberime-shared-data-dir "/usr/share/rime-data/" )
  (setq liberime-user-data-dir (file-truename "~/rime"))
  (setq pyim-default-scheme 'rime-quanpin)
  (liberime-try-select-schema "rime_ice")
  )


(use-package! pyim
  :after-call after-find-file pre-command-hook
  :init
  (setq pyim-dcache-directory (concat doom-cache-dir "pyim/"))
  (setq pyim-title "R")
  :config
  (setq pyim-dcache-auto-update nil)
  (setq pyim-cloudim nil)
  (setq pyim-page-tooltip 'posframe
        default-input-method "pyim")

  (global-set-key ( kbd "s-j") 'pyim-convert-string-at-point)

  (after! evil-escape
    (defun +chinese--input-method-p ()
      current-input-method)
    (add-to-list 'evil-escape-inhibit-functions #'+chinese--input-method-p))

  ;; allow vertico/selectrum search with pinyin
  (cond ((modulep! :completion vertico)
         (advice-add #'orderless-regexp
                     :filter-return
                     (if (modulep! :editor evil +everywhere)
                         #'evil-pinyin--build-regexp-string
                       #'pyim-cregexp-build)))
        ((modulep! :completion ivy)
         (setq ivy-re-builders-alist '((t . pyim-cregexp-ivy))))))


(use-package! liberime
  :when (modulep! +rime)
  :init
  (setq liberime-auto-build t
        liberime-user-data-dir (file-name-concat doom-cache-dir "rime")))


(use-package! pyim-liberime
  :when (modulep! +rime)
  :after liberime
  :config
  (setq pyim-default-scheme 'rime))


(use-package! pangu-spacing
  :hook (text-mode . pangu-spacing-mode)
  :config
  ;; Always insert `real' space in org-mode.
  (setq-hook! 'org-mode-hook pangu-spacing-real-insert-separtor t))


(use-package! fcitx
  :after evil
  :config
  (when (setq fcitx-remote-command
              (or (executable-find "fcitx5-remote")
                  (executable-find "fcitx-remote")))
    (fcitx-evil-turn-on)))


(use-package! ace-pinyin
  :after avy
  :init (setq ace-pinyin-use-avy t)
  :config (ace-pinyin-global-mode t))


(use-package! evil-pinyin
  :when (modulep! :editor evil +everywhere)
  :after evil
  :config
  (setq-default evil-pinyin-with-search-rule 'always)
  (global-evil-pinyin-mode 1))


;;
;;; Hacks

(defadvice! +chinese--org-html-paragraph-a (args)
  "Join consecutive Chinese lines into a single long line without unwanted space
when exporting org-mode to html."
  :filter-args #'org-html-paragraph
  (cl-destructuring-bind (paragraph contents info) args
    (let* ((fix-regexp "[[:multibyte:]]")
           (fixed-contents
            (replace-regexp-in-string
             (concat "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)")
             "\\1\\2"
             contents)))
      (list paragraph fixed-contents info))))


;; org-structure-template 和 program-mode 让 pyim 的输入法只能通过自动探针来切换中英。
;; 要么就通过 C-\ 来开关 pyim, 探针模式在代码文件里默认只在注释项中开启中文，否则只能 s-j
;; ;; 强制开启中文转换。
  (setq-default pyim-english-input-switch-functions
                '(
                  pyim-probe-dynamic-english
                  ;; pyim-probe-auto-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-evil-normal-mode
                  pyim-probe-org-structure-template
                  ))

  (setq-default pyim-punctunation-half-wideth-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))


;; 通过 key-chord 来绑定字符和命令
;; 绑定 key-chord 到rime 函数
(require 'key-chord)
(key-chord-mode 1)
(defun rime--enable-key-chord-fun (orig key)
  (if (key-chord-lookup-key (vector 'key-chord key))
      (let ((result (key-chord-input-method key)))
        (if (eq (car result) 'key-chord)
            result
          (funcall orig key)))
    (funcall orig key)))

(advice-add 'pyim-input-method :around #'rime--enable-key-chord-fun)

(key-chord-define-global " j" 'pyim-convert-string-at-point)
(key-chord-define-global " k" 'pyim-convert-string-at-point)
(key-chord-define-global "jk" 'evil-escape)
