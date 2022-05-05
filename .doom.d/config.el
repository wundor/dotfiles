;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "WundoR"
      user-mail-address "wundor@testchamber.one")

;; (after! doom-themes
    ;; (set-face-attribute 'default nil :height 150)
;; )

;; (after! doom-modeline
;;   (doom-modeline-def-modeline 'main
;;     '(bar matches buffer-info remote-host buffer-position parrot selection-info)
;;     '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "                    "))) ; <-- added padding here

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type t)

(setq scroll-margin 10)

(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

(add-hook 'evil-insert-state-exit-hook (lambda () (save-some-buffers t)))

(setq doom-font (font-spec :family "Iosevka" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 21)
      doom-big-font (font-spec :family "Iosevka" :size 34))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-directory "~/git/space/")
(after! org
  (setq org-agenda-files (directory-files-recursively "~/git/space/org" "\\.org$"))
  )

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

(after! org
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-date-format "%Y-%m-%d")
  (add-to-list 'org-agenda-files org-journal-dir)
  (setq org-journal-enable-agenda-integration t)
  (setq org-roam-dailies-directory "journal/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %<%H:%M> %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  )

(setq beancount-number-alignment-column 60)
(setq lsp-beancount-langserver-executable "~/.cargo/bin/beancount-language-server")
(setq lsp-beancount-journal-file "~/git/space/ledger/current.beancount")
