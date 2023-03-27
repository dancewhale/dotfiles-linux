;;; gtd-agende.el --- this is my package .   -*- lexical-binding: t -*-

;;; Commentary:
;;  my code of agenda setting.

(setq org-log-done 'time)

(use-package org-agenda
  :ensure nil ;; this is how you tell use-package to manage a sub-package
  :custom
  ;; a useful view to see what can be accomplished today
  (org-agenda-custom-commands '(("g" "Scheduled today and all NEXT items"
                                 ((agenda "" ((org-agenda-span 1))) (todo "NEXT"))))))

(setq org-todo-keyword-faces '(("NEXT" :foreground "red" :weight bold)))

(setq org-agenda-follow-indirect t)

;;;-------------------------------------------------
;;; org-starter的个人配置
;;;-------------------------------------------------
(use-package org-starter
  :config
  (org-starter-def "~/Dropbox/gtd"
                   :files
                   ("inbox.org"              :agenda t  :key "i" :refile (:maxlevel . 1))
                   ("work.org"               :agenda t  :key "w" :refile (:maxlevel . 1))
                   ("life.org"               :agenda t  :key "l" :refile (:maxlevel . 1))
                   ("events.org"             :agenda t  :key "e" )
                   ("work.org_archive"       :agenda t )
                   ("life.org_archive"       :agenda t )
                   ))
(setq org-agenda-files nil)

(setq org-agenda-entry-text-maxlines 3)

(after! org (setq org-capture-templates nil))

(org-starter-def-capture "d" "Task should done right now." entry
                         (file+olp+datetree "events.org" "Inbox")
                         "* DONE  %?   \n %T")
(org-starter-def-capture "e" "Event happend need to write down." entry
                         (file+olp+datetree "events.org" "Inbox")
                         "*  %?    :EVENT:\n %T")
(org-starter-def-capture "i" "TASK plan to do." entry
                         (file "inbox.org" )
                            "* TODO  %? ")

;;;----------------------------------------------------------
;;; org-ql的过滤
;;;----------------------------------------------------------
;;设置显示在side-window中
(setq org-ql-view-display-buffer-action nil)
(setq cao-gtd-assginee-list '("caoyuanzhi" "lizhun" "qinguangrui"
                              "penglu" "weihuizhou" "qiuzhiqiang"
                              "wangqiwei"))

(defun cao-gtd-set-assginee ()
  "当前任务设置负责人"
  (interactive)
  (ivy-read "Set assginee to task: " cao-gtd-assginee-list
            ;; :preselect (ivy-thing-at-point)
            :preselect "caoyuanzhi"
            :require-match t
            :action (lambda (x)
                      (if (eq major-mode 'org-agenda-mode )
                          (cao-org-agenda-set-property "assginee" x)
                        (org-set-property "assginee" x)))
            ))

(defun cao-gtd-get-assginee ()
  "选择获取任务负责人"
  (interactive)
  (ivy-completing-read "Set assginee to task: " (append cao-gtd-assginee-list '("all" "none"))))

(defun cao-gtd-filter-assginee ()
  "Show assginee task."
  (interactive)
  (org-ql-search (list "~/Dropbox/gtd/inbox.org" "~/Dropbox/gtd/work.org")
    ;; 本来是只要查询语句'(query),我这里做了ivy的条件过滤,
    ;; 根据ivy的选择来变动query.
    (progn (setq cao-gtd-assginee (cao-gtd-get-assginee))
           (cond ((string-equal cao-gtd-assginee "all") '(property "assginee"))
                 ((string-equal cao-gtd-assginee "none") '(and (not (property "assginee")) (todo "TODO" "WAIT" "DONE" "KILL") ))
                 (t `(property "assginee" ,cao-gtd-assginee))  ))
  :title (concat "Task of user:  "  cao-gtd-assginee)
  :sort '(date priority todo)
  :super-groups (if (string-equal cao-gtd-assginee "all")
                    '((:auto-property "assginee"))
                  '((:auto-parent t)))))

;; custom function from lisp code.
(defun cao-org-agenda-set-property (prop val)
  "Set a property for the current headline."
  (org-agenda-check-no-diary)
  (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
           (org-agenda-error)))
     (buffer (marker-buffer hdmarker))
     (pos (marker-position hdmarker))
     (inhibit-read-only t)
     newhead)
    (org-with-remote-undo buffer
       (with-current-buffer buffer
          (widen)
          (goto-char pos)
          (org-show-context 'agenda)
          (org-set-property prop val)))))

(defun cao-print-major-mode()
    (interactive)
    (print major-mode))

;;; setting keyshort
(general-define-key
  :prefix "s-e"
  "a a"   'cao-gtd-filter-assginee
  "a s"   'cao-gtd-set-assginee
  "a r"   'org-refile)

;;; gtd-agenda.el
