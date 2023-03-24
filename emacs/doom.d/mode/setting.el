;;; ~/.doom.d/mode/setting.el -*- lexical-binding: t; -*-

(require 'forge)
(add-to-list 'forge-alist '("gitlab.kylincloud.org" "gitlab.kylincloud.org/api/v4" "gitlab.kylincloud.org" forge-gitlab-repository))

(setq evil-normal-state-cursor '(box "light blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

;;;-------------------------------------------------
;; 增加全局快捷键
;;;-------------------------------------------------
;;;跳转gtd文件
(general-define-key
  :prefix "s-e"
  "j"   'org-starter-find-file-by-key
  "i"   'org-roam-goto-inbox
  "d"   'notdeft
  "g"   'magit
  "s-c" 'evil-yank
  "h k" 'general-describe-keybindings)

;;; 跳转roam的index文件
(defun org-roam-goto-inbox ()
  (interactive)
  (evil-edit (car (org-roam-id-find "a3370c7f-db40-4461-99e8-10ad583bef61"))))

;;; 设置roam相关快捷键
( general-define-key
  :prefix "s-e"
  "n" 'org-narrow-to-subtree
  "w" 'widen)

(general-define-key
 :prefix "C-c"
 "d t" 'org-roam-dailies-goto-today
 "d y" 'org-roam-dailies-goto-yesterday
 "d t" 'org-roam-dailies-goto-tomorrow
 "d n" 'org-roam-dailies-goto-next-note
 "d p" 'org-roam-dailies-goto-previous-note
 "d d" 'org-roam-dailies-goto-date)


(require 'cnfonts)
(require 'ox-hugo)
(cnfonts-enable)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  my code of chezmoi.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq chezmoi-dir "~/.local/share/chezmoi/")
(general-define-key
 :prefix "s-e"
 "s-f"   'doom/find-file-in-private-config)


;;;-------------------------------------------------
;; forge配置快捷键
;;;-------------------------------------------------
(general-define-key
  :prefix "s-e"
  "f t"   'forge-toggle-closed-visibility
  "f e"   'magit-edit-thing
  "f c"   'forge-create-issue
  "f r"   'forge-reset-database
  "f p"   'forge-pull)


;;;-------------------------------------------------
;; lispy配置快捷键
;;;-------------------------------------------------
(general-define-key
  :prefix "s-e"
  "s-["   'sp-unwrap-sexp
  "s-]"   'sp-wrap-round)

;;;-------------------------------------------------
;; system setting
;;;-------------------------------------------------
(setq exec-path  (append (list "/opt/homebrew/bin") exec-path))
