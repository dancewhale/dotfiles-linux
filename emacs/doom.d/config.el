;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; Global Config for Mac and linux.
;;
;; pre function.
;; get os arch.
(defun get-os-arch()
  (let* (( cmd "printf %s \"$(uname -m)\""))
    (setq os--arch (prog1 (shell-command-to-string cmd))))
  (cond ((string= os--arch "x86_64") (setq os-arch "amd64"))
		((string= os--arch "arm64") (setq os-arch "arm64"))
        ((string= os--arch "aarch64") (setq os-arch "arm64"))))

(get-os-arch)

;; config code
(setq emacs_dep_path (file-truename "~/dotfiles/bin/"))
(setq roam_path (concat (file-truename "~/Dropbox/") "roam"))

(when IS-MAC
  (progn
    (setq envpath (concat emacs_dep_path "mac/" os-arch))
    (setq system_font "Kai")
    (setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
    (message "config for darwin.")
  )
)

(when IS-LINUX
  (progn
    (setq envpath (concat emacs_dep_path "linux/" os-arch))
    (setq system_font "WenQuanYi Micro Hei Mono-14")
    (setq org-roam-graph-viewer "")
    (message "config for linux.")
    ;; Fix MacOS shift+tab
    (define-key key-translation-map [S-iso-lefttab] [backtab])
    ;; Fix conventional OS keys in Emacs
    (map! "s-`" #'other-frame  ; fix frame-switching
          ;; fix OS window/frame navigation/manipulation keys
          "s-w" #'delete-window
          "s-W" #'delete-frame
          "s-n" #'+default/new-buffer
          "s-N" #'make-frame
          "s-q" (if (daemonp) #'delete-frame #'save-buffers-kill-terminal)
          "C-s-f" #'toggle-frame-fullscreen
          ;; Restore somewhat common navigation
          "s-l" #'goto-line
          ;; Restore OS undo, save, copy, & paste keys (without cua-mode, because
          ;; it imposes some other functionality and overhead we don't need)
          "s-f" #'swiper
          "s-z" #'undo
          "s-Z" #'redo
          "s-v" #'yank
          "s-s" #'save-buffer
          "s-x" #'execute-extended-command
          :v "s-x" #'kill-region
          ;; Buffer-local font scaling
          "s-+" #'doom/reset-font-size
          "s-=" #'doom/increase-font-size
          "s--" #'doom/decrease-font-size
          ;; Conventional text-editing keys & motions
          "s-a" #'mark-whole-buffer
          "s-/" (cmd! (save-excursion (comment-line 1)))
          :n "s-/" #'evilnc-comment-or-uncomment-lines
          :v "s-/" #'evilnc-comment-operator
          :gi  [s-backspace] #'doom/backward-kill-to-bol-and-indent
          :gi  [s-left]      #'doom/backward-to-bol-or-indent
          :gi  [s-right]     #'doom/forward-to-last-non-comment-or-eol
          :gi  [M-backspace] #'backward-kill-word
          :gi  [M-left]      #'backward-word
          :gi  [M-right]     #'forward-word)

  )
)

(load-file (concat doom-private-dir "mode/setting.el"))
(load-file (concat doom-private-dir "mode/function.el"))
(load-file (concat doom-private-dir "mode/keymap.el"))
(load-file (concat doom-private-dir "mode/gtd-agenda.el"))
(load-file (concat doom-private-dir "mode/theme.el"))

;; enable keyfreq
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; 暂时取消gpg的使用
;; ~/.authinfo.gpg文件使用明文
;; machine gitlab.kylincloud.org/api/v4 login dancewhale^forge  password  testpass

(epa-file-disable)


;;;-------------------------------------------------
;; notdeft配置
;;;-------------------------------------------------
(require 'notdeft-org9)
(setenv "XAPIAN_CJK_NGRAM" "1")

(evil-set-initial-state 'notdeft-mode 'emacs)
(setq notdeft-xapian-program (concat envpath "/notdeft-xapian"))
(setq notdeft-allow-org-property-drawers "true")
(setq notdeft-directories `(,roam_path))

;;;-------------------------------------------------
;; roam 的配置
;;;-------------------------------------------------
(setq org-roam-v2-ack t)

(setq  org-roam-capture-templates '(("d" "default" plain "%?"
     :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                     "#+title: ${title}\n#+filetags: ")
     :unnarrowed t)))

(use-package org-roam
      :ensure t
      :custom
      (org-roam-directory  roam_path)
      :bind (("C-c n l" . org-roam-buffer-toggle)
             ("C-c n f" . org-roam-node-find)
             ("C-c n g" . org-roam-graph)
             ("C-c n i" . org-roam-node-insert)
             ("C-c n c" . org-roam-capture)
             ;; Dailies
             ("C-c n j" . org-roam-dailies-capture-today))
      :config
      (org-roam-setup))


;;;-------------------------------------------------
;; org-editor启动
;;;-------------------------------------------------
(require 'anki-editor)


;;;-------------------------------------------------
;; sis setting
;;;-------------------------------------------------
(use-package sis
  :config
  ;; (sis-ism-lazyman-config
  ;;  "com.apple.keylayout.US"
  ;;  "com.sogou.inputmethod.sogou.pinyin")
  ;; (sis-ism-lazyman-config
  ;;  "xkb:us::eng"
  ;;  "libbopomofo"
  ;;  'ibus)
  (sis-ism-lazyman-config
   "1"
   "2"
   'fcitx5)


  ;; enable the /cursor color/ mode
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t)
)

;;;-------------------------------------------------
;;; org-journal的个人配置,该包主要用于工作学习日志
;;;-------------------------------------------------
(require 'org-journal)

(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-date-entry)
  :custom
  (org-journal-date-prefix  "#+title: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-dir roam_path)
  (org-journal-date-format "%A, %d %B %Y")
 )

(after! org
  (setq org-tags-column -70))


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
