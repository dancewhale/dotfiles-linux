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
  :config
  (setq auto-save-default nil)
  (setq auto-fill-mode 0)
  (setq visual-line-mode 1)
  (setq
      org-startup-indented t
      org-enforce-todo-dependencies nil
      org-pretty-entities t
      org-use-sub-superscripts "{}"
      org-hide-emphasis-markers t
      org-hide-leading-stars t
      ;; show actual italicized text instead of /italicized text/
      ; org-odd-levels-only t
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-startup-with-inline-images t
      org-image-actual-width '(600)
      org-return-follows-link t
      org-ellipsis "  ▼"
      )
  :init
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org_archive$" . org-mode))

  ;; General org-mode agenda eneration speedups
  (setq org-agenda-dim-blocked-tasks nil)

  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-t" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)


  (setq org-agenda-skip-deadline-if-done t)
  ;; (setq org-agenda-skip-scheduled-if-done t)
  (setq org-deadline-warning-days 5)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 0)

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
	("t" "TODO view"
	 (( todo "" ( (org-agenda-span 1)
		     ( org-super-agenda-groups
		       '(
			 (:auto-group t)))))))
	("u" "Super view"
	 ((agenda "" ( (org-agenda-span 1)
		       (org-super-agenda-groups
			'(
			  (:name "Inbox"
			   :file-path ".*inbox.org")
			  (:name "test"
				 :todo "TODO")
			  (:name "Today"
			   :tag ("bday" "ann" "hols" "cal" "today")
			   :time-grid t
			   :todo ("WIP")
			   :deadline today
			   :scheduled today)
			  (:name "Overdue"
			   :deadline past)
			  (:name "Reschedule"
			   :scheduled past)
			  (:name "Perso"
			   :tag "perso")
			  (:name "Due Soon")
			  ))))
	  (tags (concat "w" (format-time-string "%V")) ((org-agenda-overriding-header  (concat "--\nToDos Week " (format-time-string "%V")))
	  						(org-super-agenda-groups
	  						 '((:discard (:deadline t))
	  						   (:discard (:scheduled t))
	  						   (:discard (:todo ("DONE")))
	  						   (:name "Ticklers"
	  						    :tag "someday")
	  						   (:name "Perso"
	  						    :and (:tag "perso" :not (:tag "someday")))
	  						   (:name "Work"
	  						    :and (:tag "work" :not (:tag "someday")))
	  						   (:name "Uni"
	  						    :and (:tag "uni" :not (:tag "someday")))
	  						   ))))
	  ))
	))

