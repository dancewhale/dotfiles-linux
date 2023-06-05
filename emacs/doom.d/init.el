;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load in.
;; Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find information about all of Doom's modules
;;      and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c g k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c g d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
       ;; chinese
       ;; japanese
       ;; layout

       :completion
       ;; company           ; the ultimate code completion backend
       (helm
	+childframe)             ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       (ivy
	+childframe)                              ; a search engine for love and life
       vertico					  ; Tomorrow search engine

       :ui
       deft                             ; notational velocity for Emacs
       doom                   ; what makes DOOM look the way it does
       doom-dashboard         ; a nifty splash screen for Emacs
       doom-quit              ; DOOM quit-message prompts when you quit Emacs
       (emoji
	+ascii
	+github
	+unicode)
       hl-todo     ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       ;;indent-guides            ; highlighted indent columns
       ligatures                  ; replace bits of code with pretty symbols
       minimap		          ; minimap of buffer in sidebar
       modeline                   ; snazzy, Atom-inspired modeline, plus API
       nav-flash                  ; blink the current line after jumping
       ;;neotree                  ; a project drawer, like NERDTree for vim
       ophints                    ; highlight the region an operation acts on
       (popup +defaults)          ; tame sudden yet inevitable temporary windows
       ;;tabs                     ; an tab bar for Emacs
       (treemacs +lsp)            ; a project drawer, like neotree but cooler
       ;;unicode           ;会引入报错，除非必须否则不引入 extended unicode support for various languages
       vc-gutter        ; vcs diff in the fringe
       vi-tilde-fringe  ; fringe tildes to mark beyond EOB
       window-select    ; visually switch windows
       workspaces       ; tab emulation, persistence & separate workspaces
       zen               ; distraction-free coding or writing

       :editor
       (evil
	+everywhere
	+evil-escape)
       file-templates                   ; auto-snippets for empty files
       fold                             ; (nigh) universal code folding
       (format +onsave)                 ; automated prettiness
       ;;god                            ; run Emacs commands without modifier keys
       lispy                            ; vim for lisp, for people who don't like vim
       multiple-cursors                 ; editing in many places at once
       ;;objed                          ; text object editing for the innocent
       ;;parinfer                       ; turn lisp into python, sort of
       rotate-text               ; cycle region at point between text candidates
       snippets                  ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +icons)                   ; making dired pretty [functional]
       electric                   ; smarter, keyword-based electric-indent
       ibuffer                    ; interactive buffer management
       (undo)
       vc                         ; version-control and Emacs, sitting in a tree

       :term
       ;;eshell            ; a consistent, cross-platform shell (WIP)
       shell                    ; a terminal REPL for Emacs
       ;;term              ; terminals in Emacs
       vterm             ; another terminals in Emacs

       :checkers
       syntax        ; tasing you for every semicolon you forget
       ;;spell             ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       ansible
       biblio
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       ;;direnv
       tree-sitter
       docker
       ;;editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)                  ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup                  ; helps you navigate your code and documentation
	+docsets)               ; ...or in Dash docsets locally
       (lsp +peek)
       (magit
	+forge)
       make                     ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       ;;pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb        ; creating color strings
       ;; taskrunner       ; integates taskrunner
       terraform  ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       (tty +osc)
       (:if IS-MAC macos)               ; MacOS-specific commands

       :lang
       ;;agda              ; types of types of types of types...
       ;;beancount         ; support Beancount
       ;;cc                ; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       ;;(dart +flutter)   ; Dart language support
       data                ; config/data formats
       ;; dhall            ; Dhall language support
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp          ; drown in parentheses
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor            ; factor language support
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; Godot game engine script language support
       (go +lsp
	+tree-sitter)      ; the hipster dialect
       ;;(haskell +dante)  ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ;
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
       json                ; Json support
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;latex             ; writing papers in Emacs has never been so fun
       ;;lean
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       markdown      ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;;nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org          ; organize your plain life in plain text
	+journal     ; org-journal record your life
	+dragndrop   ; drag & drop files/images into org buffers
	+roam2       ; roam package for note manager.
	+hugo        ; use Emacs for hugo blogging
	+ipython     ; ipython/jupyter support for babel
	+pandoc      ; export-with-pandoc support
	+pomodoro    ; be fruitful with the tomato technique
	+present)    ; using org-mode for presentations
       ;;php               ; perl's insecure younger brother
       ;;plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       (python
	+pyright
	+lsp)              ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; Raku programming language perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       ;;scheme            ; a fully conniving family of lisps
       sh     ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;swift             ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       ;;web               ; the tubes
       (yaml
	+lsp
	+tree-sitter)
       ;; zig              ; Zig support

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar          ; calender sync google
       ;;emms              ; a media player for music
       ;;everywhere        ; system-wide popup emacs window
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :config
       ;;literate
       (default +bindings )

       ;; 我自己的模块
       :dancewhale
       ;; pyim             ; 该输入法计划使用lisp原生输入法，但还没完工，目前使用rime。
       rime
       tools
       agenda
       gtd
       daemon
       editor
       function
       keymap
       note
       theme
       os
       lang
       term
       any
       )
