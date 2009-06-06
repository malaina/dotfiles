(add-to-list 'auto-mode-alist
             '("/mutt-|\\.*mutt-*\\|.article\\|\\.followup"
               . mail-mode))
(add-hook 'mail-mode-hook
          (lambda()
            (auto-fill-mode t)
            (setq fill-column 80)
            (local-set-key "\C-Xk" 'server-edit)
            (require-soft 'footnote-mode)
            (require-soft 'boxquote)
            (flyspell-mode t)
            (abbrev-mode 1)
            (highlight-80+-mode t)
            (local-set-key (kbd "C-c C-j l")  'set-justification-left)
            (local-set-key (kbd "C-c C-j f")  'set-justification-full)
            (footnote-mode t)))

(add-hook 'find-file-hooks (lambda ()
     (when (string-match "^mutt-.*-[0-9]+-[0-9]+-[0-9]+$"
                         (file-name-nondirectory (buffer-file-name)))
       (set (make-local-variable 'backup-inhibited) t)
       (when (looking-at "^From:")
         (flush-lines "^\\(> \n\\)*> -- \\(\\(\n> .*\\)+\\|$\\)")
         (not-modified)
         (search-forward "\n\n" nil t))
       (mail-mode))))

(defun mutt-search-header (regexp)
  (goto-char (point-min))
  (while (not (or (eolp) (looking-at regexp)))
    (forward-line 1))
  (not (eolp)))

(defun mutt-find-file-coding-system (arg-list)
  "\
Determine the coding system of a mail file.  Use the current locale if the
file doesn't declare a charset (in practice, when composing a mail message
instead of editing one).  This is a heuristic."
  (if (eq (car arg-list) 'insert-file-contents)
      (let ((case-fold-search t))
        (save-excursion
          (goto-char (point-min))
          (cond
           ((looking-at "^From:")  ;; Composed mail (new mail or reply).
            locale-coding-system)
           ((and (mutt-search-header "Content-Transfer-Encoding: 8bit")
                 (mutt-search-header
                  "Content-Type:.*charset=\"?\\([-0-9a-z]*\\)"))
            (let ((charset (intern (downcase (match-string 1)))))
              (if (memq charset (coding-system-list))
                  (progn
                    (message "Found charset %s in header." charset)
                    charset)
                'undecided-unix)))
           (t 'undecided-unix))))
    'undecided-unix))

(modify-coding-system-alist 'file "/mutt-.*-[0-9]+-[0-9]+-[0-9]+\\'"
                            'mutt-find-file-coding-system)

(defun djcb-snip (b e summ)
  "remove selected lines, and replace it with [snip:summary (n lines)]"
  (interactive "r\nsSummary:")
  (let ((n (count-lines b e)))
    (delete-region b e)
    (insert (format "[snip%s (%d line%s)]"
                    (if (= 0 (length summ)) "" (concat ": " summ))
                    n
                    (if (= 1 n) "" "s")))))
