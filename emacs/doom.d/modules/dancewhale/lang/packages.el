;; -*- no-byte-compile: t; -*-
;;; dancewhale/lang/packages.el

(package! lsp-bridge
  :recipe (:host github :repo "manateelazycat/lsp-bridge" :branch "master"
	   :files ("acm" "core" "langserver" "multiserver" "test" "*.py" "*.el")))

(package! tree-sitter
  :recipe (:host github :repo "dancewhale/elisp-tree-sitter" :branch "master"))

;; ldap-mode 的相关包
(package! ldap-mode
  :recipe (:host github :repo "emacs-lsp/dap-mode" :branch "master"))

(package! lsp-docker
  :recipe (:host github :repo "emacs-lsp/lsp-docker" :branch "master"))

(package! lsp-treemacs
  :recipe (:host github :repo "emacs-lsp/lsp-treemacs" :branch "master"))

(package! dui
  :recipe (:host github :repo "alezost/bui.el" :branch "master"))
