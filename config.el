;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "DeadMeme"
      user-mail-address "deadunderscorememe@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))



;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
(setq doom-themes-treemacs-theme "nerd-icons")
(setq doom-font (font-spec :family "MesloLGS NF" :size 16)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 16)
      doom-big-font (font-spec :family "MesloLGS NF" :size 18))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Setting custom changes made to imported packages
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default custom-file (expand-file-name "custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

(setenv "NODE_PATH" "/home/deadmeme/.nvm/versions/node/v16.8.0/lib/node_modules")

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2)                            ; It's nice to maintain a little margin
(display-time-mode 1)                             ; Enable time in the mode-line
(setq-default history-length 1000)

(setq-default prescient-history-length 1000)

(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:seperate
    company-ispell
    company-files
    company-yasnippet))

(use-package company
  :diminish company-mode
  :bind (:map company-active-map
              ("<tab>" . nil)
              ("TAB" . nil)
              ("M-<tab>" . company-complete-common-or-cycle)
              ("M-<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.01)
  :config
  )

(use-package company-prescient
  :after company
  :config
  (company-prescient-mode 1)
  (prescient-persist-mode)
  )

(use-package flycheck
  :diminish flycheck-mode
  :init
  (setq flycheck-check-syntax-automatically '(save new-line)
        flycheck-idle-change-delay 5.0
        flycheck-display-errors-delay 0.9
        flycheck-highlighting-mode 'symbols
        flycheck-indication-mode 'left-fringe
        flycheck-standard-error-navigation t
        flycheck-deferred-syntax-check nil)
  )

(setq projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos/"))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

;;(setq ispell-dictionary "en-US")

(use-package! etrace
  :after elp)

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

(elcord-mode)

(after! org

  (setq org-directory "~/org"                       ; let's put files here
        org-log-done 'time                          ; having the time a item is done sounds convenient
        org-list-allow-alphabetical t               ; have a. A. a) A) list bullets
        org-export-in-background t                  ; run export processes in external emacs process
        org-catch-invisible-edits 'smart            ; try not to accidently do weird stuff in invisible regions
        org-export-with-sub-superscripts '{})       ; don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}

  (setq org-babel-default-header-args
        '((:session . "none")
          (:results . "replace")
          (:exports . "code")
          (:cache . "no")
          (:noweb . "no")
          (:hlines . "no")
          (:tangle . "no")
          (:comments . "link")))

  (use-package! org-pretty-table
    :commands (org-pretty-table-mode global-org-pretty-table-mode))

  (remove-hook 'text-mode-hook #'visual-line-mode)
  (add-hook 'text-mode-hook #'auto-fill-mode)


  (map! :map evil-org-mode-map
        :after evil-org
        :n "g <up>" #'org-backward-heading-same-level
        :n "g <down>" #'org-forward-heading-same-level
        :n "g <left>" #'org-up-element
        :n "g <right>" #'org-down-element)

  (evil-define-command evil-buffer-org-new (count file)
    "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
    :repeat nil
    (interactive "P<f>")
    (if file
        (evil-edit file)
      (let ((buffer (generate-new-buffer "*new org*")))
        (set-window-buffer nil buffer)
        (with-current-buffer buffer
          (org-mode)))))
  (map! :leader
        (:prefix "b"
         :desc "New empty ORG buffer" "o" #'evil-buffer-org-new))

  (add-hook 'org-mode-hook 'turn-on-flyspell)

  (use-package! org-super-agenda
    :commands org-super-agenda-mode)

  (after! org-agenda
    (org-super-agenda-mode))
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-tags-column 100 ;; from testing this seems to be a good value
        org-agenda-compact-blocks t)

  (setq org-agenda-custom-commands
        '(("o" "Overview"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :date today
                            :todo "TODAY"
                            :scheduled today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Next to do"
                             :todo "NEXT"
                             :order 1)
                            (:name "Important"
                             :tag "Important"
                             :priority "A"
                             :order 6)
                            (:name "Due Today"
                             :deadline today
                             :order 2)
                            (:name "Due Soon"
                             :deadline future
                             :order 8)
                            (:name "Overdue"
                             :deadline past
                             :face error
                             :order 7)
                            (:name "Assignments"
                             :tag "Assignment"
                             :order 10)
                            (:name "Issues"
                             :tag "Issue"
                             :order 12)
                            (:name "Emacs"
                             :tag "Emacs"
                             :order 13)
                            (:name "Projects"
                             :tag "Project"
                             :order 14)
                            (:name "Research"
                             :tag "Research"
                             :order 15)
                            (:name "To read"
                             :tag "Read"
                             :order 30)
                            (:name "Waiting"
                             :todo "WAITING"
                             :order 20)
                            (:name "University"
                             :tag "uni"
                             :order 32)
                            (:name "Trivial"
                             :priority<= "E"
                             :tag ("Trivial" "Unimportant")
                             :todo ("SOMEDAY" )
                             :order 90)
                            (:discard (:tag ("Chore" "Routine" "Daily")))))))))))


  (use-package! doct
    :commands doct)

  (add-hook 'org-mode-hook #'+org-pretty-mode)

  (custom-set-faces!
    '(outline-1 :weight extra-bold :height 1.25)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold))

  (custom-set-faces!
    '(org-document-title :height 1.2))

  (setq org-agenda-deadline-faces
        '((1.001 . error)
          (1.0 . org-warning)
          (0.5 . org-upcoming-deadline)
          (0.0 . org-upcoming-distant-deadline)))

  (setq org-fontify-quote-and-verse-blocks t)

  (defun locally-defer-font-lock ()
    "Set jit-lock defer and stealth, when buffer is over a certain size."
    (when (> (buffer-size) 50000)
      (setq-local jit-lock-defer-time 0.05
                  jit-lock-stealth-time 1)))

  (add-hook 'org-mode-hook #'locally-defer-font-lock)

  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(setq org-roam-directory (file-truename "~/roam"))
(org-roam-db-autosync-mode)

(use-package! ox-gfm
  :after ox)

(use-package! spotify)
(map! :leader
      (:prefix ("d" . "Spotify")
               "p" #'spotify-playpause
               "n" #'spotify-next
               "b" #'spotify-previous
               "c" #'spotify-current
               "q" #'spotify-quit))

(use-package! vimish-fold
  :after evil)

(setq projectile-project-search-path '("~/Projects/"))

(use-package! lsp-ivy
  :after lsp-mode
  )

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor nil)
  :config
  (setq lsp-ui-doc-position 'bottom)
  )

(use-package treemacs-nerd-icons
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package! lsp-treemacs
  :after (lsp-mode treemacs)
  )

(use-package! blacken
  :init
  (setq-default blacken-fast-unsafe t)
  (setq-default blacken-line-length 80)
  )

(setq lsp-file-watch-threshold 6000)

(use-package! org-projectile
  :config
  (org-projectile-per-project)
  (progn
    (setq org-projectile-per-project-filepath "Keikaku.org")
    (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    (push (org-projectile-project-todo-entry) org-capture-templates)
    )
  )

(map! :leader
      (:prefix ("P" . "Org-Projectile")
               "n" #'org-projectile-project-todo-completing-read
               "c" #'org-capture))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

(use-package! conda
  :init
  (setq conda-anaconda-home (expand-file-name "/home/deadmeme/mambaforge"))
  (setq conda-env-home-directory (expand-file-name "/home/deadmeme/mambaforge/envs/")))

(setq lsp-auto-guess-root 'nil)

(lsp-treemacs-sync-mode 1)

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-<right>" . 'copilot-accept-completion)
              ("RET" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(use-package! snakemake-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.smk" . snakemake-mode)))

(setq projectile-enable-caching nil)

