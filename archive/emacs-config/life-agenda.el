;;; life-agende.el --- this is my package .   -*- lexical-binding: t -*-

;;; Commentary:
;;  my code of agenda setting.
;;

;;; Code:


;;;-------------------------------------------------
;;; org的个人配置,如何记录、如何作笔记。
;;;-------------------------------------------------
(setq org-directory "~/Dropbox/org")

(setq org-log-into-drawer t)
(setq org-clock-into-drawer t)

(setq org-todo-repeat-to-state "TODO")
(setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that plan todo.
           "PROJ(p)"  ; An ongoing project that cannot be completed in one step
           "WEEKLY(w)"  ; Something that is plan todo this week.
           "STARTED(s!)"  ; Something that is start todo tody.
           "WAIT(W@/!)"  ; Task should wait for some condition for ready.
           "DELAYED(D!)"  ; Task can't complete today delay to reset to STARTED tomorrow.
           "|"
           "DONE(d!)"  ; Task successfully completed
           "CANCELED(c@/!)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "QUESTION(v)"
           "EVENT(e)"
           "NOTE(N)"
           "IDEA(i)"
           ))) ; Task was completed

;; follow mode in another buffer show tree.
(advice-add 'org-agenda-goto :after
            (lambda (&rest args)
              (org-narrow-to-subtree)))

(setq hl-todo-keyword-faces
      `(("TODO"  . ,(face-foreground 'warning))
        ("STARTED" . ,(face-foreground 'error))
        ("NOTE" . ,(face-foreground 'success))
        ("IDEA"  . "blue")))


;;;-------------------------------------------------
;;; org-starter的个人配置
;;;-------------------------------------------------
(use-package org-starter
  :config
  (org-starter-def "~/Dropbox/org"
                   :files
                   ("GTD/gtd.org"         :agenda t :key "g" :refile (:maxlevel . 1))
                   ("GTD/notes.org"       :agenda t :key "n" :refile (:maxlevel . 1))
                   ("GTD/work.org"        :agenda t :key "w" :refile (:maxlevel . 1))
                   ("GTD/myself.org"      :agenda t :key "m" :refile (:maxlevel . 1))
                   ("GTD/events.org"      :agenda t :key "e" )))


(after! org (setq org-capture-templates nil))

(org-starter-define-file "gtd.org" :directory "~/Dropbox/org/GTD" :agenda t)
(org-starter-define-file "notes.org" :directory "~/Dropbox/org/GTD" :agenda t)
(org-starter-def-capture "t" "TASK plan to do." entry
              (file+headline "gtd.org" "Inbox")
                 "* TODO  %?    \t       %^g" :prepend t)
(org-starter-def-capture "m" "My things plan to do." entry
              (file+headline "myself.org" "Inbox")
                 "* TODO  %?    \t       %^g" :prepend t)
(org-starter-def-capture "i" "IDEAS of things what I want and feel." entry
              (file+olp+datetree "notes.org" "Inbox")
                 "* IDEA  %? \t       %^g" :prepend t)
(org-starter-def-capture "e" "Event happend need to write down." entry
              (file+olp+datetree "events.org" "Inbox")
                 "*  %?    :EVENT:\n %T")


;;;-------------------------------------------------
;;; super-agenda的个人配置
;;;-------------------------------------------------
(use-package! org-super-agenda
  :config
  (add-hook! 'after-init-hook 'org-super-agenda-mode)
  (require 'org-habit)
  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   org-agenda-include-deadlines t
   org-agenda-include-diary nil
   org-agenda-block-separator nil
   org-agenda-compact-blocks t
   org-agenda-start-with-log-mode t)
)

(setq org-journal-enable-agenda-integration t)
(require 'org-super-agenda)


;;;-------------------------------------------------
;;; org-ql-views的个人配置
;;;-------------------------------------------------
(require 'org-ql-view)
;; example for org-ql-views.
;;(push '("Test Calendar: Todaytest"
;;        :title "Today"
;;        :buffers-files org-agenda-files
;;        :query (ts-active :on today)
;;        :sort (priority)
;;        :super-groups org-super-agenda-groups)
;;      org-ql-views)

(setq org-agenda-custom-commands
      '(("g" "Custom GTD: Agenda for gtd tasks."
         (
          (org-ql-block '(todo "STARTED")
                        ((org-ql-block-header "Started task.")))
          (org-ql-block '(todo "NEXT")
                        ((org-ql-block-header "Next task.")))
          (org-ql-block '(and (todo "TODO")(not (scheduled :from +3)))
                        ((org-ql-block-header "TODO task.")))
         ))))

(defun cao/org-ql-search-proj ()
  "Show task."
  (interactive)
  (org-ql-search (org-agenda-files)
  '(and (todo) (ancestors (todo "PROJ")))
  :title "Today"
  :sort '(priority)
  :super-groups '((:auto-parent t))))

(custom-set-variables '(org-ql-views
      '(("Overview: Agenda-like Today" :buffers-files org-agenda-files
         :query  (and (not (done))
                      (or  (habit)  (deadline auto)  (scheduled :to today)  (ts-active :on today)))
         :title "Agenda-like Today"
         :sort  (date priority todo)
         :super-groups org-super-agenda-groups)
        ("Work task: GROUPS work task." :buffers-files org-agenda-files
         :query (and (todo "NEXT" "TODO" "STARTED" "PROJ") (path "work.org") (not (scheduled :from 3)))
         :title "Overview: PROJECT releate group task"
         :sort  (priority date)
         :super-groups ((:auto-parent t)))
        ("Myself task" :buffers-files org-agenda-files
         :query (and (todo "NEXT" "TODO" "STARTED" "PROJ") (path "myself.org"))
         :title "Task of myself."
         :sort  (priority date)
         :super-groups ((:auto-parent t)))
        ("Review: Recently timestamped" . org-ql-view-recent-items)
        ("Project: Project tasks" :buffers-files org-agenda-files
         :query (or (ancestors  (todo "PROJ"))
                    (todo "PROJ"))
         :title "Assign: Project task."
         :sort  (date priority todo)
         :super-groups  ((:auto-parent t))))))


(cao-leader-def "s-s" 'cao/org-ql-search-proj)
(cao-leader-def "v"   'org-ql-view)
(provide 'life-agenda.el)

;;;; org-ql调试后的正确代码，存档.
(setq org-agenda-custom-commands
      '(("ces" "Custom: Agenda Task for caoyuanzhi"
         ((org-ql-block '(property "assginee" "caoyuanzhi")
                        ((org-ql-block-header "Task for caoyuanzhi")))
          ))))

(setq org-ql-views
      '(("Assignee:"
         :buffers-files org-agenda-files
         :query (property "assginee")
         :sort (date priority todo)
         :title "Assignee"
         :super-groups ((:auto-property "assginee")))
       ("Overview: Agenda-like Today"
         :buffers-files org-agenda-files
         :query (property "assginee")
         :title "Agenda-like Today"
         :sort (date priority todo))
      )
)

;;; life-agenda.el
