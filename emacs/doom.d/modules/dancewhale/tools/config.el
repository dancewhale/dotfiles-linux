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


(require 'origami)

(use-package origami
  :demand
  :config
  (define-prefix-command 'origami-mode-map)
  (define-key ctl-x-map (kbd "z") 'origami-mode-map)
  (global-origami-mode)
  :bind
  (:map origami-mode-map
   ("o" . origami-open-node)
   ("O" . origami-open-node-recursively)
   ("c" . origami-close-node)
   ("C" . origami-close-node-recursively)
   ("a" . origami-toggle-node)
   ("A" . origami-recursively-toggle-node)
   ("R" . origami-open-all-nodes)
   ("M" . origami-close-all-nodes)
   ("v" . origami-show-only-node)
   ("k" . origami-previous-fold)
   ("j" . origami-forward-fold)
   ("x" . origami-reset)))


(add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)

(map! :map yaml-mode-map :desc "tab in yaml" :n [tab] #'hs-toggle-hiding)
