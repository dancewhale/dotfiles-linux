;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; Global Config for Mac and linux.
;;
;; config code
(setq roam_path (concat (file-truename "~/Dropbox/") "roam"))

(when IS-MAC
  (progn
    (setq system_font "Kai")
    (setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
    (message "config for darwin.")
  )
)

(when IS-LINUX
  (progn
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

;; 暂时取消gpg的使用
;; ~/.authinfo.gpg文件使用明文
;; machine gitlab.kylincloud.org/api/v4 login dancewhale^forge  password  testpass

(epa-file-disable)

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

