;;; dancewhale/gtd/config.el -*- lexical-binding: t; -*-

;; ========== Org mode ==========

(use-package org
  :ensure org-contrib
  :defer t
  :hook
  (org-mode . flyspell-mode)
  (before-save . zp/org-set-last-modified)
  :config
  (setq auto-save-default nil)
  (setq variable-pitch-mode 1)
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

  (setq org-agenda-files (directory-files "~/Dropbox/roam/gtd" "obsolute" "\\.org$\\|\\.org_archive$"))

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

) ; End of org-mode use-package block


;; ========== Text mode config ===========
; wrap at 80
;; (add-hook 'text-mode-hook (lambda() (turn-on-auto-fill) (set-fill-column 80)))
(setq ispell-extra-args '("--lang=en_CA"))

(with-eval-after-load 'org-faces
  (require 'org-indent)
  ;; set basic title font
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :height 1.0)
  (set-face-attribute 'org-level-3 nil :height 1.0 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.1)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  ; (setq org-cycle-level-faces nil)
  ; (setq org-n-level-faces 4)
  ;; hide #+TITLE:
  (setq org-hidden-keywords '(title))
  (set-face-attribute 'org-document-title nil
		      :height 1.75
		      :foreground 'unspecified
		      :inherit 'org-level-1)
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  ;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

  ;; Get rid of the background on column views
  (set-face-attribute 'org-column nil :foreground nil :background "#0F111B" :inherit 'fixed-pitch)
  (set-face-attribute 'org-column-title nil :background nil)
  (setq org-todo-keyword-faces '(("DONE" :foreground "green" weight bold) ("STRT" :foreground "pink" :weight bold)))
  )

(add-hook 'org-mode-hook
 (lambda ()
   (variable-pitch-mode 1)
    visual-line-mode))

(setq org-agenda-custom-commands
      '(
	("r" "Resonance Cal" tags "Type={.}"
	 ((org-agenda-files
	   (directory-files-recursively
	    "~/Dropbox/roam/refs/rez" "\\.org$"))
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

	;; org-super-agenda super view
	("u" "Super view"
	 ((agenda "" ( (org-agenda-span 1)
		       (org-super-agenda-groups
			'(
			  (:name "Inbox"
			   :tag "inbox")
			  (:name "Today"
			   :tag ("bday" "ann" "hols" "cal" "today")
			   :time-grid t
			   :todo ("WIP")
			   :deadline today
			   :scheduled today)
			  (:name "Inbox"
			   :tag "inbox")
			  (:name "Overdue"
			   :deadline past)
			  (:name "Reschedule"
			   :scheduled past)
			  (:name "Perso"
			   :tag "perso")
			  (:name "Due Soon"
			   :deadline future
			   :scheduled future)
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
							   (:name "Ping"
							    :tag "crm")
							   ))))
	  ))))

(use-package org-super-agenda
  :defer t
  :config
  (org-agenda nil "u")
  )

(org-super-agenda-mode t)

(defun cmp-date-property-stamp (prop)
"Compare two `org-mode' agenda entries, `A' and `B', by some date property.
If a is before b, return -1. If a is after b, return 1. If they
are equal return nil."
;; source: https://emacs.stackexchange.com/questions/26351/custom-sorting-for-agenda/26369#26369
(let ((prop prop))
	     #'(lambda (a b)
		 (let* ((a-pos (get-text-property 0 'org-marker a))
			(b-pos (get-text-property 0 'org-marker b))
			(a-date (or (org-entry-get a-pos prop)
				    (format "<%s>" (org-read-date t nil "now"))))
			(b-date (or (org-entry-get b-pos prop)
				    (format "<%s>" (org-read-date t nil "now"))))
			(cmp (compare-strings a-date nil nil b-date nil nil)))
		   (if (eq cmp t) nil (cl-signum cmp))
		   ))))


;; ============= Org pretty table ====================
(add-hook 'org-mode-hook (lambda () (org-pretty-table-mode)))


;;--------------------------
;; Handling file properties for ‘CREATED’ & ‘LAST_MODIFIED’
;;--------------------------

  (defun zp/org-find-time-file-property (property &optional anywhere)
    "Return the position of the time file PROPERTY if it exists.
When ANYWHERE is non-nil, search beyond the preamble."
    (save-excursion
      (goto-char (point-min))
      (let ((first-heading
	     (save-excursion
	       (re-search-forward org-outline-regexp-bol nil t))))
	(when (re-search-forward (format "^#\\+%s:" property)
				 (if anywhere nil first-heading)
				 t)
	  (point)))))

  (defun zp/org-has-time-file-property-p (property &optional anywhere)
    "Return the position of time file PROPERTY if it is defined.
As a special case, return -1 if the time file PROPERTY exists but
is not defined."
    (when-let ((pos (zp/org-find-time-file-property property anywhere)))
      (save-excursion
	(goto-char pos)
	(if (and (looking-at-p " ")
		 (progn (forward-char)
			(org-at-timestamp-p 'lax)))
	    pos
	  -1))))

  (defun zp/org-set-time-file-property (property &optional anywhere pos)
    "Set the time file PROPERTY in the preamble.
When ANYWHERE is non-nil, search beyond the preamble.
If the position of the file PROPERTY has already been computed,
it can be passed in POS."
    (when-let ((pos (or pos
			(zp/org-find-time-file-property property))))
      (save-excursion
	(goto-char pos)
	(if (looking-at-p " ")
	    (forward-char)
	  (insert " "))
	(delete-region (point) (line-end-position))
	(let* ((now (format-time-string "[%Y-%m-%d %a %H:%M]")))
	  (insert now)))))

  (defun zp/org-set-last-modified ()
    "Update the LAST_MODIFIED file property in the preamble."
    (when (derived-mode-p 'org-mode)
      (zp/org-set-time-file-property "MODIFIED")))
