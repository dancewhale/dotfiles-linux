;;; term/config.el -*- lexical-binding: t; -*-


(general-define-key
  :prefix "s-e"
  "i"   'vterm-toggle)

(setq vterm-toggle-hide-method 'reset-window-configration)

(setq vterm-toggle-fullscreen-p 't)

(define-key vterm-mode-map (kbd "C-/") 'vterm-undo)
