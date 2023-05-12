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
(setq doom-theme 'doom-nord-aurora)

;; DONE任务划横线
(set-face-attribute 'org-headline-done nil :strike-through t)
