;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; Global Config for Mac and linux.
;;
;; config code
(when IS-MAC
  (progn
    (setq system_font "Kai")
    (setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
    (message "config for darwin.")
  )
)

(when IS-LINUX
  (progn
    (setq system_font "WenQuanYi Micro Hei Mono-14")
    (setq org-roam-graph-viewer "")
    (message "config for linux.")
    ;; Fix MacOS shift+tab
    (define-key key-translation-map [S-iso-lefttab] [backtab])
    ;; Fix conventional OS keys in Emacs
    (map! "s-`" #'other-frame  ; fix frame-switching
          ;; fix OS window/frame navigation/manipulation keys
          "s-w" #'delete-window
          "s-W" #'delete-frame
          "s-n" #'+default/new-buffer
          "s-N" #'make-frame
          "s-q" (if (daemonp) #'delete-frame #'save-buffers-kill-terminal)
          "C-s-f" #'toggle-frame-fullscreen
          ;; Restore somewhat common navigation
          "s-l" #'goto-line
          ;; Restore OS undo, save, copy, & paste keys (without cua-mode, because
          ;; it imposes some other functionality and overhead we don't need)
          "s-f" #'swiper
          "s-z" #'undo
          "s-Z" #'redo
          "s-v" #'yank
          "s-s" #'save-buffer
          "s-x" #'execute-extended-command
          :v "s-x" #'kill-region
          ;; Buffer-local font scaling
          "s-+" #'doom/reset-font-size
          "s-=" #'doom/increase-font-size
          "s--" #'doom/decrease-font-size
          ;; Conventional text-editing keys & motions
          "s-a" #'mark-whole-buffer
          "s-/" (cmd! (save-excursion (comment-line 1)))
          :n "s-/" #'evilnc-comment-or-uncomment-lines
          :v "s-/" #'evilnc-comment-operator
          :gi  [s-backspace] #'doom/backward-kill-to-bol-and-indent
          :gi  [s-left]      #'doom/backward-to-bol-or-indent
          :gi  [s-right]     #'doom/forward-to-last-non-comment-or-eol
          :gi  [M-backspace] #'backward-kill-word
          :gi  [M-left]      #'backward-word
          :gi  [M-right]     #'forward-word)

  )
)

;; 暂时取消gpg的使用
;; ~/.authinfo.gpg文件使用明文
;; machine gitlab.kylincloud.org/api/v4 login dancewhale^forge  password  testpass

(epa-file-disable)
