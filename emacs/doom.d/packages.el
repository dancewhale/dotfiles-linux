;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

(package! notdeft
  :recipe (:host github :repo "hasu/notdeft" :branch "master"))

(package! org-modern)

(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent" :branch "main"))

(package! org-starter)

(package! lsp-bridge
  :recipe (:host github :repo "manateelazycat/lsp-bridge" :branch "master"
           :files ("acm" "core" "langserver" "multiserver" "test" "*.py" "*.el")))

(package! ox-hugo)

(package! command-log-mode)

(package! org-super-agenda)

(package! keyfreq)

(package! org-sql)

(package! org-ref)

(package! cnfonts)

(package! org-sidebar)

(package! anki-editor
  :recipe (:host github :repo "louietan/anki-editor" :branch "master"))

(package! doom-snippets :ignore t)

(package! yasnippet-snippets)

(unpin!  bibtex-completion helm-bibtex ivy-bibtex)
