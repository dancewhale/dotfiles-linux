;;; term/config.el -*- lexical-binding: t; -*-


(require 'vterm)

(setq vterm-toggle-hide-method 'reset-window-configration)

(setq vterm-toggle-fullscreen-p 't)

(map!
 (:map vterm-mode-map :desc "vterm undo" :e "C-/" #'vterm-undo)
 (:prefix "s-e"       :desc "vterm undo" :g "i" #'vterm-toggle)
 )

(evil-set-initial-state 'vterm-mode 'emacs)
