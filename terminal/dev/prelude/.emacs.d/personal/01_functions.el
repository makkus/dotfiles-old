(defun mconfig-functions ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/01_functions.el"))

(defun mconfig-init ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/02_init.el"))

(defun mconfig-packages ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/03_packages.el"))

(defun mconfig-mu4e ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/personal/04_mu4e.el"))

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

(defun makkus/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))


;; from: http://pragmaticemacs.com/emacs/to-eww-or-not-to-eww/
;; open link in firefox rather than eww
(defun makkus/mu4e-view-go-to-url-gui ()
  "Wrapper for mu4e-view-go-to-url to use gui browser instead of eww"
  (interactive)
  (let ((browse-url-browser-function 'browse-url-default-browser))
    (mu4e-view-go-to-url)))
;; browse article in gui browser instead of eww
(defun makkus/elfeed-show-visit-gui ()
  "Wrapper for elfeed-show-visit to use gui browser instead of eww"
  (interactive)
  (let ((browse-url-generic-program "/usr/bin/xdg-open"))
    (elfeed-show-visit t)))
