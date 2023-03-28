;;; dancewhale/note/config.el -*- lexical-binding: t; -*-

(setq roam_path (concat (file-truename "~/Dropbox/") "roam"))


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
