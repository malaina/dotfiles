(global-set-key (kbd "C-l") 'goto-line)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-x m") 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'clipboard-kill-region)
(global-set-key (kbd "C-c C-k") 'clipboard-kill-region)

(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-y") 'clipboard-yank)

(global-set-key (kbd "<next>")
                (lambda () (interactive)
                  (condition-case nil (scroll-up)
                    (end-of-buffer (goto-char (point-max))))))

(global-set-key (kbd "<prior>")
                (lambda () (interactive)
                  (condition-case nil (scroll-down)
                    (beginning-of-buffer (goto-char (point-min))))))

(global-set-key (kbd "<f4>") 'linum-mode)
(global-set-key (kbd "<f5>") 'call-last-kbd-macro)
(global-set-key (kbd "<f8>") 'goto-last-change-with-auto-marks)
(global-set-key (kbd "M-<f11>") 'ido-choose-from-recentf)

(mapc
 (lambda (mode)
   (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
     (add-hook mode-hook (lambda nil (local-set-key (kbd "RET") 'newline-and-indent)))))
 '(c-mode c++-mode emacs-lisp-mode html-mode lisp-mode cperl-mode
          ruby-mode sh-mode))

(global-set-key (kbd "C-c f") 'org-footnote-action)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))
