;;; dancewhale/gtd/config.el -*- lexical-binding: t; -*-

;; ========== Org mode ==========
(require 'org-super-agenda)
(org-super-agenda-mode)

(setq dailiy-agenda-view-search-file  (format-time-string "%Y.*\\.org"))
(setq org-agenda-files (append (directory-files "~/Dropbox/roam/gtd" "obsolute" "\\.org$\\|\\.org_archive$")
 				 (directory-files "~/Dropbox/roam/daily" "obsolute" dailiy-agenda-view-search-file)))

(load! "org-function.el")

(use-package org
  :ensure org-contrib
  :defer t
  :hook
  (before-save . zp/org-set-last-modified)
  :init
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org_archive$" . org-mode))

  ;; General org-mode agenda eneration speedups
  (setq org-agenda-dim-blocked-tasks nil)

  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-t" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)

  (setq calendar-week-start-day 1)
  (setq org-deadline-warning-days 5)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 0)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)

  (setq org-agenda-todo-ignore-scheduled 'all)
  (setq org-agenda-todo-ignore-deadlines 'all)
  (setq org-agenda-todo-ignore-with-date 'all)
  (setq org-agenda-tags-todo-honor-ignore-options t)

  (setq org-log-into-drawer t)
  (setq org-log-done t)
  (setq org-log-reschedule t)
  (setq org-log-redeadline t)
  (setq org-enable-priority-commands t)

  (setq org-agenda-deadline-leaders '("DUE:       " "In %3d d.: " "%2d d. ago: "))
  (setq org-agenda-scheduled-leaders '("DO:        " "Sched.%2dx: "))

  ;; prevent demoting heading also shifting text inside sections
  (setq org-adapt-indentation nil)

  ; Org Capture Inbox and refiling to Deft files
  (setq org-directory (expand-file-name "~/Dropbox/roam/"))
  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  (setq org-refile-use-outline-path 'file)              ; Show full paths for refiling
  (setq org-refile-targets
      '((nil :maxlevel . 3)
	(org-agenda-files :maxlevel . 3)))

  )
; End of org-mode use-package block

(add-hook 'org-mode-hook
 (lambda ()
    visual-line-mode))

(setq org-agenda-custom-commands
      '(
	("r" "Book " tags "Type={.}"
	 ((org-agenda-files
	   (directory-files-recursively
	    "~/Dropbox/roam/res/book" "\\.org$"))
	  (org-overriding-columns-format
	   "%35Item %Type %Start %Fin %Rating")
	  (org-agenda-cmp-user-defined
	   (cmp-date-property-stamp "Start"))
	  (org-agenda-sorting-strategy
	   '(user-defined-down))
	  (org-agenda-overriding-header "C-u r to re-run Type={.}")
	  (org-agenda-mode-hook
	   (lambda ()
	     (visual-line-mode -1)
	     (setq truncate-lines 1)
	     (setq display-line-numbers-offset -1)
	     (display-line-numbers-mode 1)))
	  (org-agenda-view-columns-initially t)))
	("w" "Week log view"
	 ((agenda "" ((org-agenda-span 1)
		      (org-agenda-span 'week)
		      (org-agenda-span 7)
		      (org-agenda-start-on-weekday 1)
		      (org-agenda-start-day "0d")
		      (org-super-agenda-groups
		       '(
			 (:name "Today"
			  :deadline today  :scheduled today :time-grid t)
			 (:discard (:anything t))
			 ))))))
	))




(setq org-ql-views  '(
		      ("Overview: Task make plan" :buffers-files org-agenda-files
		       :title "Make plan for all task, use refile and tools."
		       :query (and (not  (done) ) (todo))
		       :sort (todo priority date)
		       :super-groups
		       ((:name "Inbox: To Refile" :file-path "inbox.org")
			(:name "Overdue" :deadline past)
			(:name "Today" :deadline today :scheduled today)
			(:name "Reschedule" :scheduled past)
			(:name "Due Soon" :deadline future :scheduled future)
			(:name "Project" :file-path "projects.org")
			(:name "Area" :file-path "areas.org")
			(:name "Resource" :file-path "resources.org")))
		      ("Overview: Task need todo." :buffers-files org-agenda-files
		       :title "Agenda-like Task need todo task"
		       :query (and (not (done))
				   (todo)
				   (not (or (path "resources.org") (path "inbox.org"))))
		       :sort (todo priority date)
		       :super-groups
		       ((:name "Overdue" :deadline past)
			(:name "Today"
			 :and (:not (:todo "HOLD") :deadline today)
			 :and (:not (:todo "HOLD") :scheduled today))
			(:name "Reschedule" :scheduled past)
			(:name "Due Soon"   :deadline future :scheduled future  :todo "HOLD")
			(:name "Project"    :file-path "projects.org")
			(:name "Area"       :file-path "areas.org")))
		      ("Overview: STAR tasks" :buffers-files org-agenda-files
		       :query (todo "STAR")
		       :sort (date priority)
		       :super-groups org-super-agenda-groups
		       :title "Overview: NEXT tasks")
		      ("Calendar: This Week" :buffers-files org-agenda-files
		       :query (and (ts :from -7 :to today) (not (todo "TODO")))
		       :title "Week log"
		       :super-groups  ((:auto-ts t))
		       :sort (date closed priority))))

(general-define-key
 :prefix "s-e"
 "a a"   'org-ql-view
 "a r"   'org-agenda-refile
 "o r"   'org-starter-refile-by-key
 "j"     'org-starter-find-file-by-key)
