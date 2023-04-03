;;; ctools/config.el -*- lexical-binding: t; -*-

;; pre function.
;; get os arch.
(defun get-os-arch()
  (let* (( cmd "printf %s \"$(uname -m)\""))
    (setq os--arch (prog1 (shell-command-to-string cmd))))
  (cond ((string= os--arch "x86_64") (setq os-arch "amd64"))
        ((string= os--arch "arm64") (setq os-arch "arm64"))
        ((string= os--arch "aarch64") (setq os-arch "arm64"))))

(get-os-arch)


(setq emacs_dep_path (file-truename "~/dotfiles/bin/"))
(when IS-MAC
  (progn
    (setq envpath (concat emacs_dep_path "mac/" os-arch))
    (message "config for darwin.")
  )
)

(when IS-LINUX
  (progn
    (setq envpath (concat emacs_dep_path "linux/" os-arch))
    (message "config for linux.")
  )
)
 

;;;-------------------------------------------------
;;; lsp setting
;;;-------------------------------------------------
(require 'lsp-bridge)
(require 'lsp-bridge-jdtls)

;; 融合 `lsp-bridge' `find-function' 以及 `dumb-jump' 的智能跳转
(defun lsp-bridge-jump ()
  (interactive)
  (cond
   ((eq major-mode 'emacs-lisp-mode)
    (let ((symb (function-called-at-point)))
      (when symb
        (find-function symb))))
   (lsp-bridge-mode
    (lsp-bridge-find-def))
   (t
    (require 'dumb-jump)
    (dumb-jump-go))))

(defun lsp-bridge-jump-back ()
  (interactive)
  (cond
   (lsp-bridge-mode
    (lsp-bridge-return-from-def))
   (t
    (require 'dumb-jump)
    (dumb-jump-back))))

(setq lsp-bridge-default-mode-hooks
      '(
        python-mode-hook
        lisp-interaction-mode-hook
        lisp-mode-hook
        )
      )

;; 打开日志，开发者才需要
;; (setq lsp-bridge-enable-log t)


;;;-------------------------------------------------
;; org-editor启动
;;;-------------------------------------------------
(require 'anki-editor)


;;;-------------------------------------------------
;; notdeft配置
;;;-------------------------------------------------
(require 'notdeft-org9)
(setenv "XAPIAN_CJK_NGRAM" "1")

(evil-set-initial-state 'notdeft-mode 'emacs)
(setq notdeft-xapian-program (concat envpath "/notdeft-xapian"))
(setq notdeft-allow-org-property-drawers "true")


;; enable keyfreq
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; crux enable
(require 'crux)

(require 'cnfonts)
(cnfonts-enable)
