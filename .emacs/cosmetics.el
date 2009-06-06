(setq inhibit-splash-screen t)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

(menu-bar-mode -1)
(setq line-number-mode t)
(setq column-number-mode t)
(setq curdir (expand-file-name "."))

(when (fboundp 'set-fringe-mode)
    (set-fringe-mode 1))

(setq search-highlight t
  query-replace-highlight t)

(setq show-trailing-whitespace t)
(setq default-indicate-empty-lines t)

(blink-cursor-mode 0)
