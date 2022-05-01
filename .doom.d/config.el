(set-face-attribute 'default nil :height 150)

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type t)

(setq scroll-margin 10)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "                    "))) ; <-- added padding here

(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

(setq doom-font (font-spec :family "Iosevka Term" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 13)
      doom-big-font (font-spec :family "Iosevka Term" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-directory "~/org/")
