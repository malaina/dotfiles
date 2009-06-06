(require 'color-theme)
(defun color-theme-ootput-blue ()
  "dark color theme created by ootput, Jan. 2009."
  (interactive)
  (color-theme-install
    '(color-theme-ootput-blue
       ((foreground-color . "#B4B4B4")
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))

       (font-lock-builtin-face ((t (:italic t :foreground "#87ceeb"))))
       (font-lock-comment-face ((t (:italic t :foreground "#87cefa"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#1e90ff"))))
       (font-lock-constant-face ((t (:bold t :foreground "#6495ed"))))
       (font-lock-doc-string-face ((t (:foreground "#4169e1"))))
       (font-lock-doc-face ((t (:foreground "gray"))))
       (font-lock-reference-face ((t (:foreground "#4682B4"))))
       (font-lock-function-name-face ((t (:foreground "#1874CD"))))
       (font-lock-keyword-face ((t (:bold t :foreground "#3c3cff"))))
       (font-lock-preprocessor-face ((t (:foreground "#6396FC"))))
       (font-lock-string-face ((t (:foreground "#336C9F"))))
       (font-lock-type-face ((t (:bold t :foreground "#336C9F"))))
       (font-lock-variable-name-face ((t (:foreground "#7685de"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil
                                     :foreground "yellow"))))
       (hl-line ((t (:background "#112233"))))
       (mode-line ((t (:foreground "#ffffff" ))))
       (region ((t (:foreground nil :background "black"))))
       (show-paren-match-face ((t (:bold t :foreground "lightblue"
                                    :background "blue")))))))
