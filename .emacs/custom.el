(defun my-text-mode-hook ()
  (setq fill-column 90)
  (local-set-key "\C-Xk" 'server-edit)
  (when (require-soft 'filladapt)
    (filladapt-mode t))
  (setq make-backup-files nil))
(or (assoc "vimperator-" auto-mode-alist)
    (setq auto-mode-alist (cons '("vimperator-" . text-mode) auto-mode-alist)))
(add-hook 'text-mode-hook 'my-text-mode-hook)
(add-hook 'text-mode-hook
          (lambda()
            (auto-fill-mode t)
            (flyspell-mode t)
            (highlight-80+-mode t)))

(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  nil
  " Sensitive"
  nil
  (if (symbol-value sensitive-mode)
      (progn
        (set (make-local-variable 'backup-inhibited) t)
        (if auto-save-default
            (auto-save-mode -1)))
    (kill-local-variable 'backup-inhibited)
    (if auto-save-default
        (auto-save-mode 1))))

(setq auto-mode-alist
      (append '(("\\.gpg$" . sensitive-mode))
              auto-mode-alist))

(defun kill-all-mode-buffers (mode)
  (when (y-or-n-p (concat "Kill all "
                          (symbol-name mode)
                          " buffers? "))
    (dolist (buf (buffer-list))
      (when (eq (with-current-buffer buf major-mode) mode)
        (kill-buffer buf)))))

(defun ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (find-file (ido-completing-read "Open file: " recentf-list nil t)))

 (defun c++-mode-untabify ()
   (if (string= (substring mode-name 0 3) "C++")
       (save-excursion
         (delete-trailing-whitespace)
         (untabify (point-min) (point-max)))))

(unless window-system
  (defun xsel-cut-function (text &optional push)
    (with-temp-buffer
      (insert text)
      (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))

  (defun xsel-paste-function()
    (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
      (unless (string= (car kill-ring) xsel-output)
        xsel-output )))
  (setq interprogram-cut-function 'xsel-cut-function)
  (setq interprogram-paste-function 'xsel-paste-function))

(defadvice epg--start (around advice-epg-disable-agent activate)
  "Make epg--start not able to find a gpg-agent"
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(defun epg-disable-agent ()
  "Make EasyPG bypass any gpg-agent"
  (interactive)
  (ad-enable-advice 'epg--start 'around 'advice-epg-disable-agent)
  (ad-activate 'epg--start)
  (message "EasyPG gpg-agent bypassed"))

(defun epg-enable-agent ()
  "Make EasyPG use a gpg-agent after having been disabled with epg-disable-agent"
  (interactive)
  (ad-disable-advice 'epg--start 'around 'advice-epg-disable-agent)
  (ad-activate 'epg--start)
  (message "EasyPG gpg-agent re-enabled"))
