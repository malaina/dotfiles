;; -*- Emacs-Lisp -*-

(setq debug-on-error t)
(random t)

(setq default-mode-line-format
      '("-"
        mode-line-mule-info
        mode-line-modified
        mode-line-frame-identification
        mode-line-buffer-identification
        "  "
        (line-number-mode "   L%l--")
        (column-number-mode "C%c--")
        global-mode-string
        "%[(" mode-name mode-line-process minor-mode-alist "%n"
        ")%]--"
        (-3 . "%p")
        "-%-"))

(setq message-log-max nil)
(kill-buffer "*Messages*")
(setq gc-cons-threshold 50000000)

(add-hook 'after-init-hook 'server-start)
(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (local-set-key (kbd "C-x k") 'server-edit)))

(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

(defmacro require-soft (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(require ,feature ,file 'noerror))

(defmacro when-available (func foo)
  "*Do something if FUNCTION is available."
  `(when (fboundp ,func) ,foo))

(dolist (file '("input"
                "cosmetics"
                "dotemacschallenge"
                "stock_elisp"
                "aliases"
                "debian_packages"
                "fetched_elisp"
                "mutt"
                "org"
                "custom"
                "binds"))
  (load (concat "~/.emacs/" file)))

(when (or (featurep 'multi-tty)
          (and (null window-system)
               (getenv "TERM")
               (string-match "\\`screen" (getenv "TERM"))))
  (load "~/.emacs.d/term/screen" t t))
