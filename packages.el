;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! etrace :recipe (:host github :repo "aspiers/etrace"))

(package! info-colors :pin "47ee73cc19b1049eef32c9f3e264ea7ef2aaf8a5")

(package! elcord :pin "64545671174f9ae307c0bd0aa9f1304d04236421")

(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table") :pin "87772a9469d91770f87bfa788580fca69b9e697a")

(package! org-super-agenda :pin "a5557ea4f51571ee9def3cd9a1ab1c38f1a27af7")

(package! doct
  :recipe (:host github :repo "progfolio/doct")
  :pin "67fc46c8a68989b932bce879fbaa62c6a2456a1f")

(package! ox-gfm :pin "99f93011b069e02b37c9660b8fcb45dab086a07f")

(package! spotify)

(package! org-bullets
  :recipe (:host github :repo "sabof/org-bullets"))

(package! vimish-fold)

(package! graphviz-dot-mode )

(package! format-all)

(package! lsp-jedi)

(package! lsp-pyright)

(package! org-projectile)

(package! prettier)

(package! prettier-js)

(package! lorem-ipsum)

(package! blacken)

(package! lsp-ivy)

(package! prescient)

(package! company-prescient)

(package! lsp-treemacs)

(package! exec-path-from-shell)

(package! nov)

(package! jinja2-mode)

(package! ox-pandoc)

(unpin! org-roam company-org-roam)
