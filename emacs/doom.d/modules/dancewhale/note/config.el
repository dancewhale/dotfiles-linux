;;; dancewhale/note/config.el -*- lexical-binding: t; -*-

(setq roam_path (file-truename "~/Dropbox/roam"))
(setq journal_path (file-truename "~/Dropbox/roam/daily"))

;;;-------------------------------------------------
;; roam 的配置
;;;-------------------------------------------------
(setq org-roam-v2-ack t)

(setq org-roam-db-location (file-truename "~/Dropbox/roam/.org-roam.db"))

(load! "org-roam-capture-templates.el")

(use-package org-roam
  :init
  (setq org-roam-directory roam_path)
  (setq org-roam-file-extensions '("org" "md"))
  (setq org-roam-dailies-directory "daily")
  (setq find-file-visit-truename t)
  (setq org-roam-mode-sections
	(list #'org-roam-backlinks-section
	      ;; #'org-roam-reflinks-section
	      #'org-roam-unlinked-references-section
	      ))
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ;; Dailies
	 ("C-c d c" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  )


;; Override silly format of filenames
(cl-defmethod org-roam-node-slug ((node org-roam-node))
  "Return the slug of NODE."
  (let ((title (org-roam-node-title node))
	(slug-trim-chars '(;; Combining Diacritical Marks https://www.unicode.org/charts/PDF/U0300.pdf
			   768 ; U+0300 COMBINING GRAVE ACCENT
			   769 ; U+0301 COMBINING ACUTE ACCENT
			   770 ; U+0302 COMBINING CIRCUMFLEX ACCENT
			   771 ; U+0303 COMBINING TILDE
			   772 ; U+0304 COMBINING MACRON
			   774 ; U+0306 COMBINING BREVE
			   775 ; U+0307 COMBINING DOT ABOVE
			   776 ; U+0308 COMBINING DIAERESIS
			   777 ; U+0309 COMBINING HOOK ABOVE
			   778 ; U+030A COMBINING RING ABOVE
			   780 ; U+030C COMBINING CARON
			   795 ; U+031B COMBINING HORN
			   803 ; U+0323 COMBINING DOT BELOW
			   804 ; U+0324 COMBINING DIAERESIS BELOW
			   805 ; U+0325 COMBINING RING BELOW
			   807 ; U+0327 COMBINING CEDILLA
			   813 ; U+032D COMBINING CIRCUMFLEX ACCENT BELOW
			   814 ; U+032E COMBINING BREVE BELOW
			   816 ; U+0330 COMBINING TILDE BELOW
			   817 ; U+0331 COMBINING MACRON BELOW
			   )))
    (cl-flet* ((nonspacing-mark-p (char)
				  (memq char slug-trim-chars))
	       (strip-nonspacing-marks (s)
				       (ucs-normalize-NFC-string
					(apply #'string (seq-remove #'nonspacing-mark-p
								    (ucs-normalize-NFD-string s)))))
	       (cl-replace (title pair)
			   (replace-regexp-in-string (car pair) (cdr pair) title)))
      (let* ((pairs `(("[^[:alnum:][:digit:]]" . "-")  ;; convert anything not alphanumeric
		      ("--*" . "-")                    ;; remove sequential underscores
		      ("^-[:digit;]-" . "")            ;; remove starting underscores
		      ("-$" . "")))                    ;; remove ending underscores
	     (slug (-reduce-from #'cl-replace (strip-nonspacing-marks title) pairs)))
	(downcase slug)))))

; ;; for org-roam-buffer-toggle
; ;; Recommendation in the official manual
(add-to-list 'display-buffer-alist
	     '("\\*org-roam\\*"
	       (display-buffer-in-direction)
	       (direction . right)
	       (window-width . 0.33)
	       (window-height . fit-window-to-buffer)))



;;;-------------------------------------------------
;;; org-journal的个人配置,该包主要用于工作学习日志
;;;-------------------------------------------------
(require 'org-journal)

;; (use-package org-journal
;;   :bind
;;   ("C-c n j" . org-journal-new-date-entry)
;;   :custom
;;   (org-journal-date-prefix  "#+title: ")
;;   (org-journal-file-format "%Y-%m-%d.org")
;;   (org-journal-dir roam_path)
;;   (org-journal-date-format "%A, %d %B %Y")
;;  )

(after! org
  (setq org-tags-column -70))

;; Org Journal config
(use-package org-journal
  :defer t
  :custom
  (org-journal-dir journal_path)
  (org-journal-file-type 'yearly)
  ; (org-extend-today-until 01)
  (org-journal-file-format "journal-%Y.org")
  (org-journal-date-format "%Y-%m-%d %a")
  (org-journal-created-property-timestamp-format "%Y-%m-%d")
  (org-journal-encrypt-journal t)
  (org-journal-enable-cache t)
  (org-journal-carryover-items nil))


;; devel package
(use-package delve
  :after (org-roam)
  ;; this is necessary if use-package-always-defer is true
  :demand t
  :bind
  ;; the main entry point, offering a list of all stored collections
  ;; and of all open Delve buffers:
  (("<f12>" . delve))
  :config
  ;; set meaningful tag names for the dashboard query
  (setq delve-dashboard-tags '("Tag1" "Tag2"))
  ;; optionally turn on compact view as default
  (add-hook #'delve-mode-hook #'delve-compact-view-mode)
 ;; turn on delve-minor-mode when Org Roam file is opened:
  (delve-global-minor-mode))


(use-package vulpea
  :ensure t
  ;; hook into org-roam-db-autosync-mode you wish to enable
  ;; persistence of meta values (see respective section in README to
  ;; find out what meta means)
  :hook ((org-roam-db-autosync-mode . vulpea-db-autosync-enable)))
