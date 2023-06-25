;; -*- no-byte-compile: t; -*-
;;; dancewhale/note/packages.el

(package! org-transclusion)

;; 组合使用
(package!  delve
  :recipe (:host github :repo "publicimageltd/delve"
	   :branch "main" :files ("*.el")))

(package! org-roam-search
  :recipe (:host github :repo "natask/org-roam-search" :branch "master"))

(package! sexp-string
  :recipe (:host github :repo "natask/sexp-string" :branch "master"))

(package!  delve-show
  :recipe (:host github :repo "natask/delve-show" :branch "master" :files ("*.el")))

(package! vulpea)
