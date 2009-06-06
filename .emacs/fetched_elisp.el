(require-soft 'color-theme)
(require-soft 'color-theme-x)
(load "~/.emacs.d/color-theme-ootput-blue.el")
(setq color-theme-is-global t)
(color-theme-ootput-blue)

(when (locate-library "crontab-mode")
  (autoload 'crontab-mode "crontab-mode" "mode for editing crontab" t)
  (add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'"
  . crontab-mode))
  (add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."
  . crontab-mode))
)

(require-soft 'dtrt-indent)
(dtrt-indent-mode 1)
(autoload 'dtrt-indent-mode "dtrt-indent" "Adapt to foreign indentation offsets" t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "linux")
            (dtrt-indent-mode t)))
(add-hook 'sh-mode-common-hook 'dtrt-indent-mode)
(add-hook 'ruby-mode-common-hook 'dtrt-indent-mode)
(add-hook 'perl-mode-common-hook 'dtrt-indent-mode)

(autoload 'ion3-mode "ion3" "Major mode to edit ion3 config files" t)

(require-soft 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

(require-soft 'gitsum)

(autoload 'muttrc-mode "muttrc-mode" "muttrc-mode" t 'nil)
(add-to-list 'auto-mode-alist '("\\.muttrc\\'"   . muttrc-mode))
(add-hook 'muttrc-mode-hook 'highlight-80+-mode)

(require-soft 'smex)
(smex-initialize)
(setq smex-save-file "~/.emacs.d/smex.save")
(smex-auto-update)

(require-soft 'highline)
(defun highline-mode-on () (highline-mode 1))
;; Turn on local highlighting for Dired (C-x d)
(add-hook 'dired-after-readin-hook #'highline-mode-on)
;; Turn on local highlighting for list-buffers (C-x C-b)
(defadvice list-buffers (after highlight-line activate)
   (save-excursion
     (set-buffer "*Buffer List*")
     (highline-mode-on)))
(setq highline-face 'highlight)

(require-soft 'goto-last-change)

(require-soft 'highlight-80+)

(when (require-soft 'cursor-chg)
  (change-cursor-mode 1)
  (toggle-cursor-type-when-idle 1)
  (setq curchg-default-cursor-color "Blue"))
