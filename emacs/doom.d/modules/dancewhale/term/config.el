;;; term/config.el -*- lexical-binding: t; -*-


(general-define-key
  :prefix "s-e"
  "i"   'vterm-toggle)

(setq vterm-toggle-hide-method 'reset-window-configration)
