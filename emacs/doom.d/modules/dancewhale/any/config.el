;;; dancewhale/any/config.el -*- lexical-binding: t; -*-
;; config code

;; magit configure
(with-eval-after-load 'forge
  (add-to-list 'forge-alist
	       '("gitlab.kylincloud.org"
		 "gitlab.kylincloud.org/api/v4"
		 "kylin"
		 forge-gitlab-repository)))
