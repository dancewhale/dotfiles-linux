;; -*- no-byte-compile: t; -*-
;;; ctools/packages.el

(package! cnfonts)

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

(package! org-ref)

(package! org-sidebar)

(package! origami)

(package! highlight-indent-guides)

(package! leetcode)

(package! eaf
  :recipe (:host github :files ("*")
	   :repo "emacs-eaf/emacs-application-framework" :branch "master"))

(package! chezmoi
  :recipe (:host github :repo "tuh8888/chezmoi.el" :branch "main"))

(package! kubedoc)
