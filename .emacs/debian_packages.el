(load "dictionary-init")
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)

(fset 'yes-or-no-p 'y-or-n-p)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(add-hook `latex-mode-hook `flyspell-mode)
(add-hook `tex-mode-hook `flyspell-mode)
(add-hook `bibtex-mode-hook `flyspell-mode)

(require-soft 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require-soft 'git)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/org")
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(require-soft 'muse-mode)     ; load authoring mode
(require-soft 'muse-html)     ; load publishing styles I use
(require-soft 'muse-latex)
(require-soft 'muse-context)
(require-soft 'muse-project)  ; publish files in projects

(require-soft 'planner)

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(autoload 'python-mode "python-mode" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

(if (= emacs-major-version 23)
    (require-soft 'w3m-load)
  (require-soft 'w3m))

(autoload 'lbdb "lbdb" "Query the Little Brother's Database" t)
(autoload 'lbdb-region "lbdb" "Query the Little Brother's Database" t)
(autoload 'lbdb-maybe-region "lbdb" "Query the Little Brother's Database" t)

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
