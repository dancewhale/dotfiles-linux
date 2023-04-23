;;; org-roam-capture-templates.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 whale
;;
;; Author: whale <whale@fedora>
;; Maintainer: whale <whale@fedora>
;; Created: 四月 03, 2023
;; Modified: 四月 03, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/dancewhale/org-roam-capture-templates
;; Package-Requires: ((emacs "24.3"))
;;
;;; Code:


(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %T %?" :target  (file+datetree "%<%Y-%m>.org" day))))


(setq org-roam-capture-templates
      `(("d" "default" plain "%?"
	 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"  "${title}
#+CREATED: %u\n#+MODIFIED:\n#+FILETAGS:\n* ${title}"):unnarrowed t)
	("r" "res" plain "%?"
	 :target (file+head  ,(concat roam_path "/res/%<%Y%m%d%H%M%S>-${slug}.org")
			     "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
#+FILETAGS:
* ${title}
:PROPERTIES:
:Type: Res
:Tag:
:END:
**  ") :unnarrowed t)
	("p" "Project" plain "%?"
	 :target (file+head  ,(concat roam_path "/project/%<%Y%m%d%H%M%S>-${slug}.org")
			     "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
#+FILETAGS:
* ${title}
:PROPERTIES:
:Type: Project
:Tag:
:END:
**  ") :unnarrowed t)
 	("b" "book" plain "%?"
	 :target (file+head  ,(concat roam_path "/res/book/book-${slug}.org")
			     "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Tag:
:Type: book
:Start:
:Fin:
:Killed:
:Rating:
:Digested:
:Creator:
:URL:
:END:
** Actions
** Key Ideas
** Review
** Quotes
** Notes
**  ") :unnarrowed t)))
