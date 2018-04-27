(defun find-config-functions ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/01_functions.el"))

(defun find-config-init ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/02_init.el"))

(defun find-config-packages ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/03_packages.el"))

(defun makkus/avy-goto-end-of-word-or-subword-1 ()
  (interactive)
  (call-interactively 'avy-goto-word-or-subword-1)
  (forward-word)
  )

(defun makkus/avy-goto-end-of-line ()
  (interactive)
  (call-interactively 'avy-goto-line)
  (end-of-line)
  )

(defun makkus/org-find-and-enter ()
  "Find imenu heading, go to it, then enter subtree there and show children"
  (interactive)
  (helm-imenu)
  (org-narrow-to-subtree)
  (show-children)
  )

(defun makkus/comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

(defun makkus/my-new-line ()
  "Insert a newline, skipping potential string after point on current line."
  (interactive "*")
  (end-of-line)
  (newline)
  )

(defun makkus/recenter-no-redraw (&optional arg)
  "Like `recenter', but no redrawing."
  (interactive "P")
  (let ((recenter-redisplay nil))
    (recenter arg)))

(setq pop-mark-repeat-keymap
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "m") #'makkus/pop-mark-repeat)
        (define-key map (kbd "q") #'keyboard-quit)
        map))
(defun makkus/pop-mark-repeat ()
  (interactive)
  (pop-to-mark-command)
  (set-transient-map
   pop-mark-repeat-keymap))
