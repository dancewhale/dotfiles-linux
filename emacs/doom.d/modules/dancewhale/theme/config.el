;;; ../.local/share/chezmoi/dotfiles/doom.d/mode/theme.el -*- lexical-binding: t; -*-

;;;---------------------------------------------------
;;;  cnfonts字体配置
;;;---------------------------------------------------
(setq cnfonts-personal-fontnames
      '(("更纱黑体 Mono Sc Nerd" "Monaco"  "Courier" "Courier New")
        ("更纱黑体 Mono Sc Nerd" "苹方-简" "微软雅黑" "报隶-简" "冬青黑体简体中文" "黑体-简" "Noto Sans Mono CJK SC")
        ("更纱黑体 Mono Sc Nerd" "HanaMinB")
        ("更纱黑体 Mono Sc Nerd")
        ("更纱黑体 Mono Sc Nerd" "NanumGothic" "Arial Unicode MS")))

;;;-------------------------------------------------
;; 修改默认doom的theme
;;;-------------------------------------------------
(setq doom-theme 'doom-dracula)

(use-package! org-modern
  :ensure t
  :custom
  (org-modern-hide-stars nil)           ; adds extra indentation
  :after org
  :config
  (setq org-modern-star '( "☯" "☷" "☲" "☵"))
  (add-hook 'org-mode-hook #'org-modern-mode)
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))

(use-package org-modern-indent
  ;; :straight or :load-path here, to taste
  :hook
  (org-indent-mode . org-modern-indent-mode))
;; 取消行号显示，否则block显示error
(setq display-line-numbers-type nil)


;; 使用 org-superstar package
;; (after! org-superstar
;; ;;   (setq org-superstar-headline-bullets-list '( "☯" "☷" "☲" "☵")
;; ;;         org-superstar-prettify-item-bullets t ))
