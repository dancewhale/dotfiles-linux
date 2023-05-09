;; -*- no-byte-compile: t; -*-
;;; dancewhale/chinese/packages.el

(package! rime
 :recipe(:host github :repo "DogLooksGood/emacs-rime"
	 :files ("librime-emacs.so" "rime-predicates.el" "rime.el" "lib.c" "Makefile")))

(package! key-chord)

(package! ace-pinyin)
(package! pinyinlib)
