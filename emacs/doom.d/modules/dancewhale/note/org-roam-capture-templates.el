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
'(("d" "default" entry
   "* %?" :target (file+head "%<%Y-%m-%d>.org"
			     "#+title: %<%Y-%m-%d %a>
#+CREATED: %<%Y-%m-%d %a>
#+MODIFIED:
*  今日目标
The one thing
* 日志
* 想法 "))))



(setq org-roam-capture-templates
      `(("d" "default" plain "%?"
	 :target (file+head "${slug}.org"  "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
"):unnarrowed t)
	("r" "res" plain "%?"
	 :target (file+head  ,(concat roam_path "/res/${slug}.org")
			     "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Type: Res
:Tag:
:END:
** Goal:  ${title}") :unnarrowed t)
	("p" "Project" plain "%?"
	 :target (file+head  ,(concat roam_path "/project/${slug}.org")
"#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Type: Project
:Tag:
:END:
** Goal: ${title}") :unnarrowed t)))
