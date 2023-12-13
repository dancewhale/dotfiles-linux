;;; learn/config.el -*- lexical-binding: t; -*-

(setq self-learn-package-dir (file-truename "~/.doom.d/modules/learn/learn"))

(setq self-learn-resource-dir (file-truename "~/Dropbox/book"))

(setq self-learn-output-dir (file-truename "~/Dropbox/anki"))

(defun self-learn-open-resource-dir ()
  (interactive)
  (dired self-learn-resource-dir))

(defun self-learn-open-package-dir ()
  (interactive)
  (dired self-learn-package-dir))

(defun self-learn-open-output-dir ()
  (interactive)
  (dired self-learn-output-dir))


(map!
 (:prefix "s-e h"      :desc "Open self learn package dire."      :g  "h" #'self-learn-open-package-dir)
 (:prefix "s-e h"      :desc "Open self learn output dire."       :g  "a" #'self-learn-open-output-dir)
 (:prefix "s-e h"      :desc "Open self learn resource dire."     :g  "r" #'self-learn-open-resource-dir)
 (:map anki-editor-mode-map
  :desc "Push entrypoint at point."  :leader  "m p"       #'anki-editor-push-note-at-point
  :desc "Helpful open symbol at point." :leader "m h h" #'helpful-at-point
  :desc "Open symbol at point in manual." :leader "m h l" #'info-lookup-symbol)
 )
