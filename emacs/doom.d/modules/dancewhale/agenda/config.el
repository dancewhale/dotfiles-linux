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


(setq org-agenda-follow-indirect t)

;;;-------------------------------------------------
;;; org-starter的个人配置
;;;-------------------------------------------------
(use-package org-starter
  :config
  (org-starter-def "~/Dropbox/roam/gtd"
    :files
    ("inbox.org"              :agenda t  :key "i" :refile (:maxlevel . 1))
    ("areas.org"              :agenda t  :key "a" :refile (:maxlevel . 1))
    ("projects.org"           :agenda t  :key "p" :refile (:maxlevel . 1))
    ("resources.org"          :agenda t  :key "r" :refile (:maxlevel . 1))
    ))

(setq org-agenda-entry-text-maxlines 3)

(org-starter-def-capture "c" "Capture what you want." entry
			 (file+headline "inbox.org"  "inbox") "* TODO %? ")


;;;----------------------------------------------------------
;;; org-ql的过滤
;;;----------------------------------------------------------
(setq org-ql-views  '(
		      ("Overview: Task need todo." :buffers-files org-agenda-files
		       :title "Agenda-like Task need todo task"
		       :query (or (and (not (done))
				       (todo "TODO" "STRT")
				       (not (or (path "resources.org") (path "inbox.org"))))
				  (todo "STRT"))
		       :sort (todo priority date)
		       :super-groups
		       ((:name "Overdue"
			 :and (:not (:todo "HOLD") :deadline past))
			(:name "Running"
			 :todo "STRT")
			(:name "Today"
			 :and (:not (:todo "HOLD") :deadline today)
			 :and (:not (:todo "HOLD") :scheduled today)
			 :todo "STRT")
			(:name "Reschedule"
			 :and (:not (:todo "HOLD" :tag "everyday") :scheduled past))
			(:name "Due Soon"
			 :and (:not (:todo "HOLD" :tag "everyday") :deadline future)
			 :and (:not (:todo "HOLD" :tag "everyday") :scheduled future))
			(:name "Project"    :file-path "projects.org")
			(:name "Area"       :file-path "areas.org")))

		      ("Overview: Task make plan" :buffers-files org-agenda-files
		       :title "Make plan for all task, use refile and tools."
		       :query (and (not  (done) ) (todo "TODO" "STRT"))
		       :sort (todo priority date)
		       :super-groups
		       ((:name "Inbox: To Refile" :file-path "inbox.org")
			(:name "Overdue" :deadline past)
			(:name "Today" :deadline today :scheduled today :todo "STRT")
			(:name "Reschedule" :scheduled past)
			(:name "Due Soon" :deadline future :scheduled future)
			(:name "Project" :file-path "projects.org")
			(:name "Area" :file-path "areas.org")
			(:name "Resource" :file-path "resources.org")))

		      ("Overview: STAR tasks" :buffers-files org-agenda-files
		       :title "Overview: NEXT tasks"
		       :query (todo "STRT")
		       :sort (date priority)
		       :super-groups org-super-agenda-groups)

		      ("Calendar: This Week" :buffers-files org-agenda-files
		       :query (and (ts :from -7 :to today) (not (todo "TODO")))
		       :title "Week log"
		       :super-groups  ((:auto-ts t))
		       :sort (date closed priority))
		      ))


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
  (org-ql-search (list "~/Dropbox/roam/gtd/inbox.org" "~/Dropbox/roam/gtd/work.org")
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
	 (inhibit-read-only t))
    (org-with-remote-undo buffer
      (with-current-buffer buffer
	(widen)
	(goto-char pos)
	(org-fold-show-context 'agenda)
	(org-set-property prop val)))))

(defun cao-print-major-mode()
    (interactive)
    (print major-mode))

;;; setting keyshort
;; (general-define-key
;;  :prefix "s-e"

;;  "a a"   'cao-gtd-filter-assginee
;;  "a s"   'cao-gtd-set-assginee
;;  "a r"   'org-refile
;;  "j"   'org-starter-find-file-by-key)


;; Fix: org-capture-mode disable after agenda view in org-capture
(after! org
  (defadvice! dan/+org--restart-mode-h-careful-restart (fn &rest args)
    :around #'+org--restart-mode-h
    (let ((old-org-capture-current-plist (and (bound-and-true-p org-capture-mode)
					      (bound-and-true-p org-capture-current-plist))))
      (apply fn args)
      (when old-org-capture-current-plist
	(setq-local org-capture-current-plist old-org-capture-current-plist)
	(org-capture-mode +1)))))

;;; gtd-agenda.el
