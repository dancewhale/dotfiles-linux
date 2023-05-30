;; -*- no-byte-compile: t; -*-
;;; dancewhale/lang/packages.el

(package! lsp-bridge
  :recipe (:host github :repo "manateelazycat/lsp-bridge" :branch "master"
	   :files ("acm" "core" "langserver" "multiserver" "test" "*.py" "*.el")))

(package! lsp-docker
  :recipe (:host github :repo "emacs-lsp/lsp-docker" :branch "master"))

(package! dui
  :recipe (:host github :repo "alezost/bui.el" :branch "master"))
