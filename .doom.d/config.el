;; (after! doom-themes
    ;; (set-face-attribute 'default nil :height 150)
;; )

;; (after! doom-modeline
;;   (doom-modeline-def-modeline 'main
;;     '(bar matches buffer-info remote-host buffer-position parrot selection-info)
;;     '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "                    "))) ; <-- added padding here

(setq doom-theme 'doom-nord)

(set-frame-parameter (selected-frame)'alpha '(90 . 90))
(add-to-list 'default-frame-alist'(alpha . (90 . 90)))

(setq doom-font (font-spec :family "Iosevka" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 21)
      doom-big-font (font-spec :family "Iosevka" :size 34))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type t)

(setq scroll-margin 10)

(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

(add-hook 'evil-insert-state-exit-hook (lambda () (save-some-buffers t)))

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(setq org-directory "~/git/space/")
(after! org
  (setq org-agenda-files (directory-files-recursively "~/git/space/org" "\\.org$"))
  )

(setq org-roam-directory "~/git/space/")

(require 'org-roam-export)

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
