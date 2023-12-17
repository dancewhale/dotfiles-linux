;;; learn/config.el -*- lexical-binding: t; -*-

(setq learnify-source-dir (file-truename "~/.doom.d/modules/learn/learn"))

(setq learnify-book-dir (file-truename "~/Dropbox/book"))

(setq learnify-anki-dir (file-truename "~/Dropbox/anki"))

(defun learnify-open-book-dir ()
  (interactive)
  (dired learnify-book-dir))

(defun learnify-open-source-dir ()
  (interactive)
  (dired learnify-source-dir))

(defun learnify-open-anki-dir ()
  (interactive)
  (dired learnify-anki-dir))

(setq learnify-property-card-type "CARD_TYPE")
(setq learnify-property-card-link "CARD_LINK")

(defun learnify-org-property ()
  "Prompt for a property name and return its value for the current Org headline."
  (interactive)
  (let ((property (read-string "Enter property name: ")))
    (message "%s" (org-entry-get (point) property))))

(defun learnify-card-OpenLink ()
  "Open link for card"
  (interactive)
  (let* ((learnify-current-card-type (org-entry-get (point) learnify-property-card-type))
	 (learnify-current-card-link (org-entry-get (point) learnify-property-card-link))
	 (learnify-link-open-function (intern (concat "learnify-" learnify-current-card-type "-link-open"))))
    (funcall learnify-link-open-function learnify-current-card-link)))

(defun learnify-elisp-link-open (link)
  (info-lookup-symbol link 'lisp-mode)
  )

(map!
 (:prefix "s-e l h"      :desc "Open learnify source code dire."      :g  "s" #'learnify-open-source-dir)
 (:prefix "s-e l h"      :desc "Open learnify anki card dire."       :g  "a" #'learnify-open-anki-dir)
 (:prefix "s-e l h"      :desc "Open learnify book resource dire."     :g  "b" #'learnify-open-book-dir)
 (:prefix "s-e l l"      :desc "Open learnify reference Link."     :g  "r" #'learnify-card-OpenLink)
 (:map anki-editor-mode-map
  :desc "Push entrypoint at point."  :leader  "m p"       #'anki-editor-push-note-at-point
  :desc "Helpful open symbol at point." :leader "m h h" #'helpful-at-point
  :desc "Open symbol at point in manual." :leader "m h l" #'info-lookup-symbol)
 )
