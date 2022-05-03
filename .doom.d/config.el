(set-face-attribute 'default nil :height 150)

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type t)

(setq scroll-margin 10)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "                    "))) ; <-- added padding here

(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

(add-hook 'evil-insert-state-exit-hook (lambda () (save-some-buffers t)))

(setq doom-font (font-spec :family "Iosevka" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 13)
      doom-big-font (font-spec :family "Iosevka" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-directory "~/git/space/")

(setq org-roam-directory "~/git/space/")

(require 'org-roam-export)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%Y-%m-%d")
(setq org-journal-enable-agenda-integration t)

(setq org-roam-dailies-directory"journal/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %<%H:%M> %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
