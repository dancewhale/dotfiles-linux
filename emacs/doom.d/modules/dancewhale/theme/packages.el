;; -*- no-byte-compile: t; -*-
;;; dancewhale/theme/packages.el

(package! org-modern)

(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent" :branch "main"))

(package! nao-emacs
  :recipe (:host github :repo "rougier/nano-emacs" :branch "master"))
