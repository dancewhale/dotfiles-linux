(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(custom-safe-themes
   '("6f4421bf31387397f6710b6f6381c448d1a71944d9e9da4e0057b3fe5d6f2fad" default))
 '(exwm-floating-border-color "#242530")
 '(fci-rule-color "#6272a4")
 '(highlight-tail-colors
   ((("#2c3e3c" "#2a3b2e" "green")
     . 0)
    (("#313d49" "#2f3a3b" "brightcyan")
     . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(objed-cursor-color "#ffffff")
 '(org-journal-date-format "%A, %d %B %Y" nil nil "Customized with use-package org-journal")
 '(org-journal-date-prefix "#+title: " nil nil "Customized with use-package org-journal")
 '(org-journal-dir "~/Dropbox/roam/" nil nil "Customized with use-package org-journal")
 '(org-journal-file-format "%Y-%m-%d.org" nil nil "Customized with use-package org-journal")
 '(org-ql-views
   '(("Overview: Agenda-like Today" :buffers-files org-agenda-files :query
      (and
       (not
        (done))
       (or
        (habit)
        (deadline auto)
        (scheduled :to today)
        (ts-active :on today)))
      :title "Agenda-like Today" :sort
      (date priority todo)
      :super-groups org-super-agenda-groups)
     ("Work task: GROUPS work task." :buffers-files org-agenda-files :query
      (and
       (todo "NEXT" "TODO" "STARTED" "PROJ")
       (path "work.org")
       (not
        (scheduled :from 3)))
      :title "Overview: PROJECT releate group task" :sort
      (priority date)
      :super-groups
      ((:auto-parent t)))
     ("Myself task" :buffers-files org-agenda-files :query
      (and
       (todo "NEXT" "TODO" "STARTED" "PROJ")
       (path "myself.org"))
      :title "Task of myself." :sort
      (priority date)
      :super-groups
      ((:auto-parent t)))
     ("Review: Recently timestamped" . org-ql-view-recent-items)
     ("Project: Project tasks" :buffers-files org-agenda-files :query
      (or
       (ancestors
        (todo "PROJ"))
       (todo "PROJ"))
      :title "Assign: Project task." :sort
      (date priority todo)
      :super-groups
      ((:auto-parent t)))))
 '(package-selected-packages '(sis peep-dired docker))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#282a36"))
 '(rustic-ansi-faces
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")))
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil))
