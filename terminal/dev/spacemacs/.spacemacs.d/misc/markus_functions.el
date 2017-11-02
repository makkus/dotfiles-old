                                        ; package --- Summary

 ;;; Commentary:
 ;;; custom functions

 ;;; Code:

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

 (defun makkus/untabify ()
   "My untabify function as discussed and described at
  http://www.jwz.org/doc/tabs-vs-spaces.html
  and improved by Claus Brunzema:
  - return nil to get `write-contents-hooks' to work correctly
    (see documentation there)
  - `make-local-hook' instead of `make-local-variable'
  - when instead of if
  Use some lines along the following for getting this to work in the
  modes you want it to:

  \(add-hook 'some-mode-hook
            '(lambda ()
                (make-local-hook 'write-contents-hooks)
                 (add-hook 'write-contents-hooks 'ska-untabify nil t)))"
   (save-excursion
     (goto-char (point-min))
     (when (search-forward "\t" nil t)
       (untabify (1- (point)) (point-max)))
     nil))


(defun makkus/full-screen-toggle ()
  "toggle full-screen mode"
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

;;;; create pop-up org-capture frame
;;;; from: https://cestdiego.github.io/blog/2015/08/19/org-protocol/
(defadvice org-capture
    (after make-full-window-frame activate)
  "Advise capture to be the only window when used as a popup"
  (if (equal "org-capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "org-capture" (frame-parameter nil 'name))
      (delete-frame)))

;;;; from
(defun makkus/org-capture ()
  "Create a new frame and run org-capture."
  (interactive)
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))

(defun makkus/toggle-read-novel-mode ()
  "Setup current window to be suitable for reading long novel/article text.

• Line wrap at word boundaries.
• Set a right margin.
• line spacing is increased.
• variable width font is used.

Call again to toggle back."
  (interactive)
  (if (null (get this-command 'state-on-p))
      (progn
        (set-window-margins nil 0
                            (if (> fill-column (window-body-width))
                                0
                              (progn
                                (- (window-body-width) fill-column))))
        (variable-pitch-mode 1)
        (setq line-spacing 0.4)
        (setq word-wrap t)
        (put this-command 'state-on-p t))
    (progn
      (set-window-margins nil 0 0)
      (variable-pitch-mode 0)
      (setq line-spacing nil)
      (setq word-wrap nil)
      (put this-command 'state-on-p nil)))
  (redraw-frame (selected-frame)))

(global-set-key (kbd "<f9>") 'makkus/toggle-read-novel-mode)

(defun makkus/get-frame-name (frame)
  (cdr (assoc (quote name) (frame-parameters frame))))

(defun makkus/is-mu4e-frame (frame)
  (string= (makkus/get-frame-name frame) "mu4e"))


(defun makkus/is-non-mu4e-frame (frame)
  (not
   (or
    (string= (makkus/get-frame-name frame) "mu4e")
    (string= (makkus/get-frame-name frame) "F1")))
)

(defun makkus/mu4e-frame (lst)
  (first (delq nil
               (mapcar (lambda (x) (and (string= (makkus/get-frame-name x) "mu4e") x)) lst)))
  )

(defun makkus/non-mu4e-frames (lst)
  (delq nil
        (mapcar (lambda (x) (and (makkus/is-non-mu4e-frame x) x)) lst))
  )

(defun makkus/non-mu4e-frame (lst)
  (first (makkus/non-mu4e-frames lst)))


(defun makkus/window-toggle-split-direction ()
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

(global-set-key (kbd "M-SPC t C-y") 'makkus/window-toggle-split-direction)


;; from: http://stackoverflow.com/questions/36814730/emacs-helm-how-to-auto-recenter-after-jump
(defun makkus/recenter-no-redraw (&optional arg)
  "Like `recenter', but no redrawing."
  (interactive "P")
  (let ((recenter-redisplay nil))
    (recenter arg)))

(provide 'markus_functions)
