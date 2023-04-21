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

  (setq org-agenda-show-future-repeats nil)
  (setq org-log-into-drawer t)
  (setq org-log-reschedule t)
  (setq org-log-redeadline t)
  (setq org-enable-priority-commands t)

  (setq org-agenda-deadline-leaders '("DUE:       " "In %3d d.: " "%2d d. ago: "))
  (setq org-agenda-scheduled-leaders '("DO:        " "Sched.%2dx: "))

  (setq org-clock-in-switch-to-state  "STRT")
  (setq org-clock-out-switch-to-state "TODO")

  ;; prevent demoting heading also shifting text inside sections
  (setq org-adapt-indentation nil)

					; Org Capture Inbox and refiling to Deft files
  (setq org-directory (expand-file-name "~/Dropbox/roam/"))
  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-outline-path-complete-in-steps nil)	; Refile in a single go
  (setq org-refile-use-outline-path 'file)	; Show full paths for refiling
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
	 ((agenda "" ((org-agenda-span 'week)
		      (org-agenda-start-on-weekday 1)
		      (org-agenda-show-log 1)
		      (org-agenda-start-day "0d")
		      (org-super-agenda-groups
		       '(
			 (:name none
			  :deadline today  :scheduled today :time-grid t)
			 (:discard (:anything t))
			 ))))))
	("d" "Daily log view"
	 ((agenda "" ((org-agenda-span 'day)
		      (org-agenda-start-on-weekday 1)
		      (org-agenda-start-day "0d")
		      (org-agenda-show-log 1)
		      (org-super-agenda-groups
		       '(
			 (:name none
			  :deadline today  :scheduled today :time-grid t)
			 (:discard (:anything t))
			 ))))))

	))


(general-define-key
 :prefix "s-e"
 "a a"   'org-ql-view
 "a r"   'org-agenda-refile
 "o r"   'org-starter-refile-by-key
 "j"     'org-starter-find-file-by-key)

;; 遇到 minor-mode 的情况，可以通过
;; (add-hook 'org-agenda-mode-hook 'evil-normalize-keymaps)
;; (evil-set-initial-state 'org-agenda-mode 'emacs)


(define-key org-agenda-mode-map "j" 'org-agenda-next-line)
(define-key org-agenda-mode-map "k" 'org-agenda-previous-line)
(define-key org-agenda-mode-map "n" 'org-agenda-goto-date)
(define-key org-agenda-mode-map "p" 'org-agenda-capture)

;; 解决按键映射问题
(setq org-super-agenda-header-map (make-sparse-keymap))

;; 在recent file mode 中使用Vim 按键
(evil-add-hjkl-bindings recentf-dialog-mode-map 'emacs)
