(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")
(set-face-foreground 'highlight nil)

(setq transient-mark-mode t)
(setq truncate-partial-width-windows nil)
(setq case-fold-search t)

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)
(setq-default transient-mark-mode t)
(when (require-soft 'jit-lock)
  (setq jit-lock-stealth-time 1))

(set-input-method nil)

(setq linum-format "%d ")

(setq scroll-step 1)

(delete-selection-mode t)

(require-soft 'paren)
(when-available 'show-paren-mode
                (progn
                  (show-paren-mode t)
                  (setq show-paren-style 'parenthesis)
                  (set-face-background 'show-paren-match-face (face-background
                                                               'default))
                  (set-face-foreground 'show-paren-match-face "brightblue")
                  (set-face-attribute 'show-paren-match-face nil :weight
                                      'extra-bold)))

(require-soft 'align)

(setq make-backup-files t
      backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs-backup"))
      version-control t
      kept-new-versions 1
      kept-old-versions 3
      delete-old-versions t)
(setq auto-save-default nil)
(auto-save-mode -1)
(setq-default auto-save-default nil)
(setq-default auto-save-interval -1)

(setq time-stamp-active t
      time-stamp-line-limit 10
      time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)")
(add-hook 'write-file-hooks 'time-stamp)

(setq woman-use-own-frame nil)
(setq woman-fill-frame t)

(setq scalable-fonts-allowed t)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq show-trailing-whitespace t)

(require-soft 'generic-x)

(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(setq completion-ignore-case t
      read-file-name-completion-ignore-case t)
(setq completion-ignored-extensions
      '(".o" ".elc" ".class" "java~" ".ps" ".abs" ".mx" ".~jv" ))

(icomplete-mode t)

(when (require-soft 'ido)
  (progn
    (ido-mode t)
    (setq
     ido-ignore-buffers
     '("\\` " "^\*Mess" "^\*Back" "^\*scratch" ".*Completion"
       "^\*Shell" "^\*Ido")
     ido-everywhere t
     ido-case-fold  t
     ido-use-filename-at-point t
     ido-use-url-at-point t
     ido-enable-flex-matching t
     ido-default-buffer-method 'samewindow
     ido-max-prospects 5
     ido-confirm-unique-completion t
     ido-auto-merge-werk-directories-length -1)))

(require-soft 'recentf)
(setq recentf-max-saved-items 100)

(temp-buffer-resize-mode 1)
(setq temp-buffer-max-height
      (lambda (buffer)
        (min 20 (/ (- (frame-height) 2) 2))))

(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(autoload 'cperl-mode "cperl-mode" "Major mode for perl files" t)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(require-soft 'saveplace)
(setq save-place-file "~/.emacs.d/.saveplace")
(setq-default save-place t)
(setq server-visit-hook (quote (save-place-find-file-hook)))

(setq savehist-additional-variables
      '(search ring regexp-search-ring)
      savehist-autosave-interval 60
      savehist-file "~/.emacs.d/.savehist")
(savehist-mode t)

(setq abbrev-file-name
            "~/.emacs.d/.abbrev_defs")
(abbrev-mode t)
(setq default-abbrev-mode t
        save-abbrevs t)
(when (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))
(add-hook 'kill-emacs-hook
            'write-abbrev-file)

(define-derived-mode my-vcs-mode text-mode
  "VCS message" "moar doc"
  (setq save-place nil)
  (revert-buffer nil t t))

(add-to-list 'auto-mode-alist
             '("/\\.git/\\(COMMIT\\|TAG\\)_EDITMSG\\'" .
               my-vcs-mode))
(setq vc-follow-symlinks t)
(setq vc-suppress-confirm t)

(setq-default ispell-program-name "aspell")
(setq ispell-process-directory (expand-file-name "~/"))
(setq ispell-dictionary "british")

(setq
 time-stamp-active t
 time-stamp-line-limit 10
 time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)")
(add-hook 'write-file-hooks 'time-stamp)

(setq calendar-latitude -34.0)
(setq calendar-longitude +151.0)
(setq calendar-location-name "Sydney")

(setq x-select-enable-clipboard t)
