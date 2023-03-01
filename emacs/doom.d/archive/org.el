;;; ~/my/emacs_conf/cao_emacs.d/doom.d/archive/org.el -*- lexical-binding: t; -*-

;;; ----------------------------
;;; global的键位设置
;;; ----------------------------
(general-define-key
 :keymaps 'org-mode-map
 "C-c i"  'org-insert-heading)


;;; ----------------------------
;;; global的键位设置
;;; ----------------------------
(setq org-agenda-custom-commands
      '(("p" "Plan work of week."
         ((alltodo "" ((org-super-agenda-groups
                        '(
                          (:name "clear"
                           :discard (:and (:scheduled t :not (:scheduled today)))
                           :order 33)
                          (:name "PROJECT"
                                 :and (:todo  "PROJ"  :file-path "gtd\\.org")
                                 :order 1)
                          (:name "Things asign to other persion."
                                 :and (:tag  "other"  :file-path "gtd\\.org")
                                 :order 11)
                          (:name "TODAY"
                                 :and (:todo  "STARTED"  :file-path "gtd\\.org")
                                 :scheduled today
                                 :order 2)
                          (:name "TOMORROW DELAYED"
                                 :and (:todo  "DELAYED"  :file-path "gtd\\.org")
                                 :order 3)
                          (:name "WEEKLY"
                                 :and (:todo  "WEEKLY"  :file-path "gtd\\.org")
                                 :order 4)
                          (:name "INBOX"
                                 :and (:todo  "TODO"  :file-path "gtd\\.org")
                                 :order 5)
                          (:name "WAITING"
                                 :and (:todo  "WAIT"  :file-path "gtd\\.org")
                                 :order 6)
                          (:discard (:anything))))))))
        ("ces" "Custom: Agenda and Emacs SOMEDAY [#A] items"
         ((org-ql-block '(and (todo "TODO")
                              (tags "task"))
                        ((org-ql-block-header "SOMEDAY :Emacs: High-priority")))
         (org-ql-block '(and (todo "TODO")
                              (tags "task"))
                       ((org-ql-block-header "SOMEDAY :Emacs: High-priority")))))))
