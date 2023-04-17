;;; dancewhale/lang/config.el -*- lexical-binding: t; -*-

;; golang
(setq lsp-go-gopls-server-path (expand-file-name "~/go/bin/gopls"))

(setq exec-path  (append (list (expand-file-name "~/go/bin")) exec-path))



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
        lisp-mode-hook))


;;; dap-mode
(use-package dap-mode
  :config
  (dap-mode 1)
  (setq dap-print-io t)
  (require 'dap-hydra)
  (require 'dap-dlv-go)

  (use-package dap-ui
    :ensure nil
    :config
    (dap-ui-mode 1)
    )
  )
