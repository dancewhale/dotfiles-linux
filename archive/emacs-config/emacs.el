;;; ~/my/emacs_conf/cao_emacs.d/doom.d/archive/emacs.el -*- lexical-binding: t; -*-


;;; 常用的李杀快捷键。
(package! xah-fly-keys
  :recipe (:host github :repo "xahlee/xah-fly-keys" :branch "master"))

;; https://github.com/railwaycat/homebrew-emacsmacport/issues/52
;; 解决mac下的emacs-mac包 lacks multi-tty support 的问题.
(package! mac-pseudo-daemon
  :recipe (:host github :repo "DarwinAwardWinner/mac-pseudo-daemon" ))
