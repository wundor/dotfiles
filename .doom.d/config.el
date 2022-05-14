;; (after! doom-themes
;; (set-face-attribute 'default nil :height 150)
;; )

;; (after! doom-modeline
;;   (doom-modeline-def-modeline 'main
;;     '(bar matches buffer-info remote-host buffer-position parrot selection-info)
;;     '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "                    "))) ; <-- added padding here

(setq doom-theme 'doom-nord)

(set-frame-parameter (selected-frame)'alpha '(95 . 95))
(add-to-list 'default-frame-alist'(alpha . (95 . 95)))

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
  ;; (setq org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t)))
  )

(setq org-habit-show-habits-only-for-today nil)
(setq org-habit-graph-column 65)

(setq org-log-into-drawer "LOGBOOK")

(setq org-log-done "time")

(setq org-agenda-clockreport-parameter-plist '(:stepskip0 t :link t :maxlevel 2 :fileskip0 t))

(map! :map org-mode-map
      :localleader
      (:prefix ("c" . "clock")
       :desc "Insert past clock" "p" #'org-insert-past-clock))

(org-super-agenda-mode)

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-day nil ;; i.e. today
      org-agenda-span 1
      org-agenda-start-on-weekday nil)

(setq org-super-agenda-unmatched-name "🔥overdue🔥")

(setq org-tags-column -80)

(setq org-agenda-custom-commands
      '(("z" "Super view"
         ((agenda "" ((org-agenda-overriding-header "")
                      (org-super-agenda-groups
                       '((:name "⏰ TODAY"
                          :time-grid t
                          :date today
                          )
                         ))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '(
                          (:log t)
                          (:name "🚀 WEEK"
                           :tag "WEEK"
                           )
                          (:name "📅 MONTH"
                           :tag "MONTH"
                           )
                          (:name "🎯 YEAR"
                           :tag "YEAR"
                           )
                          (:name "📚 BACKLOG 📚"
                           :and (
                                 :scheduled nil
                                 :deadline nil
                                 )
                           )
                          (:discard (:anything t))
                          ))))
          ))))

(setq org-roam-directory "~/git/space/brain")

(require 'org-roam-export)

(setq org-icalendar-combined-agenda-file "~/git/space/org/calendar/all.ics")
(setq org-icalendar-include-todo t)
;; (setq org-icalendar-use-scheduled (event-if-todo event-if-not-todo))
;; (setq org-icalendar-use-deadline (event-if-todo event-if-not-todo))

(after! org
  (setq org-caldav-url "https://cloud.testchamber.one/remote.php/dav/calendars/wunder")
  (setq org-caldav-calendar-id "org")
  (setq org-caldav-inbox "~/git/space/org/calendar/ical.org")
  (setq org-caldav-files (directory-files "~/git/space/org" t "\\.org$"))
  (setq org-icalendar-timezone "Europe/Moscow")
  )
(setq auth-sources '("~/.auth"))

(defun calendar-helper () ;; doesn't have to be interactive
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "White")
    (cfw:ical-create-source "Праздники" "https://calendar.google.com/calendar/ical/ru.russian%23holiday%40group.v.calendar.google.com/public/basic.ics" "Green")
    (cfw:ical-create-source "WORK" "https://outlook.office365.com/owa/calendar/bf27cd7a8e5641539bc7a06ac19b82fd@orioninc.com/84df9ea52130447b9c6e7313c391fab19555198356456158305/S-1-8-1214364109-2325842782-3623989374-2310379573/reachcalendar.ics" "Purple")
    )))
(defun calendar-init ()
  ;; switch to existing calendar buffer if applicable
  (if-let (win (cl-find-if (lambda (b) (string-match-p "^\\*cfw:" (buffer-name b)))
                           (doom-visible-windows)
                           :key #'window-buffer))
      (select-window win)
    (calendar-helper)))
(defun =my-calendar ()
  "Activate (or switch to) *my* `calendar' in its workspace."
  (interactive)
  (if (featurep! :ui workspaces) ;; create workspace (if enabled)
      (progn
        (+workspace-switch "Calendar" t)
        (doom/switch-to-scratch-buffer)
        (calendar-init)
        (+workspace/display))
    (setq +calendar--wconf (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (calendar-init)))

(setq calendar-week-start-day 1)

(setq calendar-holidays nil)

(after! org
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-date-format "%Y-%m-%d")

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  (unless (eq org-journal-file-type 'daily)
    (org-narrow-to-subtree))
  (goto-char (point-max)))

(setq org-capture-templates '(("j" "Journal entry" plain (function org-journal-find-location)
                               "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
                               :jump-to-captured t :immediate-finish t)))

(setq beancount-number-alignment-column 60)
(setq lsp-beancount-langserver-executable "~/.cargo/bin/beancount-language-server")
(setq lsp-beancount-journal-file "~/git/space/ledger/current.beancount")
