;;; learn/config.el -*- lexical-binding: t; -*-

(require 'anki-helper)

;; For developer anki code use.

(map!
 (:prefix "s-e"      :desc "Describe function use lispy-describe"     :g  "1" #'lispy-describe)
 (:prefix "s-e"      :desc "Describe function use lispy-describe"     :g  "2" #'lispy-describe-inline))
