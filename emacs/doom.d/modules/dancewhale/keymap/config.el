;;; ~/.doom.d/mode/setting.el -*- lexical-binding: t; -*-

;; (require 'forge)
;; (add-to-list 'forge-alist '("gitlab.kylincloud.org" "gitlab.kylincloud.org/api/v4" "gitlab.kylincloud.org" forge-gitlab-repository))

(setq evil-normal-state-cursor '(box "light blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

;;;-------------------------------------------------
;; 增加全局快捷键
;;;-------------------------------------------------
;;;跳转gtd文件
(map!
  :prefix "s-e"
  "d"   #'notdeft
  "g"   #'magit
  "s-c" #'evil-yank
  "h k" #'general-describe-keybindings)

;;; 跳转roam的index文件
(defun org-roam-goto-inbox ()
  (interactive)
  (evil-edit (car (org-roam-id-find "a3370c7f-db40-4461-99e8-10ad583bef61"))))

;;; 设置roam相关快捷键
(map!
  :prefix "s-e"
  "n" #'org-narrow-to-subtree
  "w" #'widen)

(map!
 :prefix "C-c"
 "d t" #'org-roam-dailies-goto-today
 "d y" #'org-roam-dailies-goto-yesterday
 "d t" #'org-roam-dailies-goto-tomorrow
 "d n" #'org-roam-dailies-goto-next-note
 "d p" #'org-roam-dailies-goto-previous-note
 "d d" #'org-roam-dailies-goto-date)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  my code of chezmoi.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq chezmoi-dir "~/.local/share/chezmoi/")
(map!
 :prefix "s-e"
 "s-f"   #'doom/find-file-in-private-config)


;;;-------------------------------------------------
;; forge配置快捷键
;;;-------------------------------------------------
;; (general-define-key
;;   :prefix "s-e"
;;   "f t"   'forge-toggle-closed-visibility
;;   "f e"   'magit-edit-thing
;;   "f c"   'forge-create-issue
;;   "f r"   'forge-reset-database
;;   "f p"   'forge-pull)


;;;-------------------------------------------------
;; lispy配置快捷键
;;;-------------------------------------------------
(map!
 :prefix "s-e"  :mode lispy-mode
 "s-["   #'sp-unwrap-sexp
 "s-]"   #'sp-wrap-round)


;;;-------------------------------------------------
;;  跳转切换配置快捷键
;;;-------------------------------------------------
(map!
 (:prefix "s-e"
  :desc "窗口撤回" :g "[" #'winner-undo
  :desc "窗口恢复" :g "]" #'winner-redo)
 :desc "前一个buffer"  :g  "C-c ["  #'previous-buffer
 :desc "后一个buffer"  :g  "C-c ]"  #'next-buffer
 )


;;;-------------------------------------------------
;; system setting
;;;-------------------------------------------------
(setq exec-path  (append (list "/opt/homebrew/bin") exec-path))


;;;-------------------------------------------------
;; projectile setting
;;;-------------------------------------------------
(map! :leader
      :desc "open project root dire" :nmg "pjr" #'projectile-dired
      :desc "select open project root dire" :nmg "pp"  #'cao/switch-project-dired
      :desc "treemacs select window" :nmg "oo"  #'treemacs-select-window
      )

(defun cao/switch-project-dired ()
  "Switch to projectile root dired."
  (interactive)
  (counsel-projectile-switch-project "D")
  )
