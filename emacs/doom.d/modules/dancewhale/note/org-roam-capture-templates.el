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
		"* %?"
		:target (file+head "%<%Y-%m-%d>.org"
"#+title: %<%Y-%m-%d %a>
#+CREATED: %<%Y-%m-%d %a>
#+MODIFIED:
*  Daily Intent
The one thing
___
??
* Log
-
** Todos
** Pings
* Perso
** [[id:873C893B-DE3B-4433-87D7-A51806D7CA16][Morning Pages]]
[[file:~/Documents/org/journal/journal-2023.org.gpg::* %<%Y-%m-%d %a>][ %<%Y-%m-%d %a>]]
** [[id:9AD761D3-02F4-40DD-AED2-13AED735290E][Storyworthy]]
** Meta
- Where: ???
- Weather: ???
- Music: ???
- Sleep: 7h?
- Weight: ???
- Energy: L/M/H
- Effective: L/M/H
- Mood:
*** [[id:50EABEC4-239C-4123-A106-4B97417D98D2][Exercise]]
*** [[id:CFB3EFF4-1237-4E35-9385-77D404611596][TIL]]
*** [[id:3F912AB7-47DB-46A3-AADB-CA9F4589C840][Highlights ]]
*** [[id:D660A331-01E0-4247-B74F-A28FAF4C30C2][Lowlights]]
*** Eats
- Breakie: ???
- Lunch: ???
- Dinner: ???
*** [[id:E50848D2-1CB5-4B0C-B1AC-B1952A37A37C][Gratitude/Savoured]]
1.
2.
3.
"))))

(setq org-roam-capture-templates
      `(("d" "default" plain "%?"
	 :target (file+head "${slug}.org"

			    "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
"):unnarrowed t)

("p" "peep" plain "%?"
 :target (file+head  ,(concat roam_path "/refs/prm/${slug}.org")
"#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Email:
:Phone:
:WeiXin:
:Current_Company:
:Current_Role:
:Location:
:END:
* ${title}'s Birthday - yyyy-mm-dd   :bday:
DEADLINE: <yyyy-mm-dd aaa +1y -4w>
* How We Met")
 :unnarrowed t)

("r" "Rez" plain "%?"
 :target (file+head  ,(concat roam_path "/refs/rez/${slug}.org")
"#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Type:
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
** Notes")
 :unnarrowed t)

("e" "Exp" plain "%?"
 :target (file+head ,(concat roam_path "/areas/exps/${slug}.org")
		    "#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* ${title}
:PROPERTIES:
:Type: Exp
:Start:
:Fin:
:Assess: <yyyy-mm-dd aaa>
:Qs:
:Status:
:Outcome:
:END:
** Actions
** Hypothesis
-
** Treatment
-
** Notes
-
** Outcome
-
** Contraindications
-")
 :unnarrowed t)

("w" "Weekly" plain "%?"
 :target (file+head ,(concat roam_path "/daily/${slug}.org")
"#+TITLE: ${title}
#+CREATED: %u
#+MODIFIED:
* Intents
Week Goal:
|----+--------+-----------+----------+---------+---------+---------------+-----------|
|    | Mon    | Tue       | Wed      | Thu     | Fri     | Sat           | Sun       |
|----+--------+-----------+----------+---------+---------+---------------+-----------|
| 🐧 |        |           |          |         |         |               |           |
|----+--------+-----------+----------+---------+---------+---------------+-----------|
| \Delta  |   |           |          |         |         |               |           |
|----+--------+-----------+----------+---------+---------+---------------+-----------|
* Commits
|---------------------------------------+-----------------------------------|
| *This Week*                           | *Q1 OKRs*                         |
|---------------------------------------+-----------------------------------|
| 1. Health:                            | 1.                                |
| 2. Astro:                             | 2.                                |
| 3. Coding:                            | 3.                                |
| 4. PhD:                               | 4.                                |
| 5. Writing:                           | 5.                                |
|---------------------------------------+-----------------------------------|
| *Next 4 Weeks*                        | *Health Metrics*                  |
|---------------------------------------+-----------------------------------|
| 1.                                    | 1.                                |
| 2.                                    | 2.                                |
| 3.                                    | 3.                                |
| 4.                                    | 4.                                |
|---------------------------------------+-----------------------------------|
Watched:
Played:
Read:
* Buckets
** Sharpen
2 wo/run + movie + game + read
⬜ ⬜ ⬜ ⬜
** Create
Blog + Book
⬜ ⬜
** Invest
COMA
⬜
** Learn
Astro + COMA Airflow + Rust
⬜ ⬜ ⬜
** Review, Plan, Prune
Buckets + Weekly Review
✅ ⬜
* Weekly Review
  ⬜✅💪❌🔼🔽¼ ½ ¾ ⅓ ⅔ ⅕ ⅖ ⅗ ⅘
** Score: XX/XX ~ XX%
** How'd it go?
** *🏆 Pluses*
1.
2.
3.
** 🔽 Minuses
1.
2.
3.
** ▶️ Next
1.
2.
3.
"):unnarrowed t)))
