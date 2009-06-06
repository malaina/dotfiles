(setq inhibit-default-init t)
(setq debug-on-error t)
(put 'narrow-to-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'overwrite-mode 'disabled t)
(global-set-key "\C-c\C-a" 'mark-whole-buffer)
(setq backup-by-copying-when-mismatch t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq require-final-newline 't)
(setq require-final-newline 'query)
(setq special-display-buffer-names
      (nconc '("*Backtrace*" "*VC-log*" "*compilation*" "*grep*")
             special-display-buffer-names))
(add-to-list 'special-display-frame-alist '(tool-bar-lines . 0))

(defun autocompile nil
  "compile itself if ~/.emacs.el"
  (interactive)
  (require-soft 'bytecomp)
  (if (string= (buffer-file-name) (expand-file-name (concat
                                                     default-directory
                                                     ".emacs.el")))
      (byte-compile-file (buffer-file-name))))
(add-hook 'after-save-hook 'autocompile)

(setq safe-local-variable-values
      (quote ((auto-recompile . t)
              (outline-minor-mode . t)
              auto-recompile outline-minor-mode)))

(global-set-key [(tab)] 'smart-tab)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (dabbrev-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          (dabbrev-expand nil)
        (indent-for-tab-command)))))
