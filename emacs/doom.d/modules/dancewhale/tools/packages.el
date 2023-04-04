;; -*- no-byte-compile: t; -*-
;;; ctools/packages.el


(package! cnfonts)

(package! ox-hugo)

(package! command-log-mode)


(package! notdeft
  :recipe (:host github :repo "hasu/notdeft" :branch "master"))

(package! keyfreq)


(package! anki-editor
  :recipe (:host github :repo "louietan/anki-editor" :branch "master"))

(package! doom-snippets :ignore t)

(package! yasnippet-snippets)

(unpin!  bibtex-completion helm-bibtex ivy-bibtex)

(package! crux)