;;; function.el --- this is my chezmoi script. -*- lexical-binding: t; -*-

;;; Commentary:
;; code of my self.

;;; Code:
(defun openssl-enc (data)
  (let* ((cmd (concat  "echo  -n  " data " | openssl rsautl -encrypt -pubin -oaep "
                        "-inkey ~/.ssh/id_rsa.pub.pem | openssl enc -A -base64")))
    (prog1  (shell-command-to-string cmd))
  )
)


(defun openssl-dec (data)
  (let* ((cmd (concat "echo -n  " data " | openssl enc -A -base64 -d"
                       " | openssl rsautl -decrypt -oaep -inkey ~/.ssh/id_rsa")))
    (prog1  (shell-command-to-string cmd))
  )
)

;; I want an easy command for opening new shells:
(defun new-local-shell (name)
  "Opens a new shell buffer with the given name in
asterisks (*name*) in the current directory and changes the
prompt to 'name>'."
  (interactive "sName: ")
  (pop-to-buffer (concat "*" name "*"))
  (unless (eq major-mode 'shell-mode)
    (shell (current-buffer))
    (sleep-for 0 200)
    (delete-region (point-min) (point-max))
    (comint-simple-send (get-buffer-process (current-buffer))
                        (concat "export PS1=\"\033[33m" name "\033[0m:\033[35m\\W\033[0m>\""))))

(global-set-key (kbd "C-c s") 'new-shell)


(setq my-remote-ssh-list `(
                   "/ssh:root@192.168.84.120:/"
                   "/ssh:root@192.168.84.121:/"
                   ,default-directory
                   ))

(defun dfeich/ansi-terminal (&optional name path)
  "Opens an ansi terminal at PATH. If no PATH is given, it uses
the value of `default-directory'. PATH may be a tramp remote path.
The ansi-term buffer is named based on `name' "
  (interactive "sName: ")
  (unless name (setq name "ansi-term"))
  (ansi-term "/bin/bash" name)
  (let* (
         (path (ivy-completing-read "Which host is connecting to?" my-remote-ssh-list))
         (path (replace-regexp-in-string "^file:" "" path))
         (cd-str
          "fn=%s; if test ! -d $fn; then fn=$(dirname $fn); fi; cd $fn;")
         (bufname (concat "*" name "*" )))
    (if (tramp-tramp-file-p path)
        (let ((tstruct (tramp-dissect-file-name path)))
          (cond
           ((equal (tramp-file-name-method tstruct) "ssh")
            (process-send-string bufname (format
                                          (concat  "ssh -t %s '"
                                                   cd-str
                                                   "exec bash'; exec bash; clear\n")
                                          (tramp-file-name-host tstruct)
                                          (tramp-file-name-localname tstruct))))
           (t (error "not implemented for method %s"
                     (tramp-file-name-method tstruct)))))
      (process-send-string bufname (format (concat cd-str " exec bash;clear\n")
                                           path))))
)


(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n"))

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n"))

(defun marginnote3-open-ext (note-id)
  (shell-command (concat "open marginnote3app://" note-id)))


(defun org-define-scheme-url ()
  (progn (org-add-link-type "marginnote3app" 'marginnote3-open-ext)))

(defun cao-emacs-magit ()
  (interactive)
  (magit-status-setup-buffer "~/.doom.d"))


(defun cao-emacs-counsel-ag ()
  (interactive)
  (counsel-ag nil default-directory))

(map! :prefix "s-e"
      "s-e g"    #'cao-emacs-magit
      "s-e s-f"  #'cao-emacs-counsel-ag)

(eval-after-load 'org '(add-hook 'org-mode-hook (lambda () (org-define-scheme-url))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  my code of chezmoi.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'chezmoi)
(setq chezmoi-dir "~/.local/share/chezmoi/")
(map!
 :prefix "s-e"
 "s-f"   #'cao/find-file-re)

(defun cao/find-file-re ()
  "Search for a file in `doom-user-dir'."
  (interactive)
  (doom-project-find-file default-directory))


;;; function.el
