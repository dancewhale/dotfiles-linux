;;; term/config.el -*- lexical-binding: t; -*-


(require 'vterm)
(general-define-key
  :prefix "s-e"
  "i"   'vterm-toggle)

(setq vterm-toggle-hide-method 'reset-window-configration)

(setq vterm-toggle-fullscreen-p 't)

(define-key vterm-mode-map (kbd "C-/") 'vterm-undo)

(evil-set-initial-state 'vterm-mode 'emacs)
