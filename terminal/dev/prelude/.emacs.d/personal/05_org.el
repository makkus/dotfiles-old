(setq org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-M-RET-may-split-line nil)

(bind-key* "C-c l" 'org-store-link)
(bind-key* "C-c a" 'org-agenda)
(bind-key* "C-c c" 'org-capture)


(setq org-default-notes-file "~/Documents/notes/tasks.org")
(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/Documents/notes/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %u\n  %a")
        ("n" "Note/Data" entry (file+headline "~/Documents/notes/notes.org" "Notes/Data")
         "* %?   \n  %i\n  %u\n  %a")
        ("j" "Journal" entry (file+datetree "~/Documents/notes/journal.org")
         "* %?\nEntered on %U\n %i\n %a")
        ))
