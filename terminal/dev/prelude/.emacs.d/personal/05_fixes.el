;; yapf empties kill ring after file save
;; reference: https://www.reddit.com/r/emacs/comments/4vo9qh/losing_killring_on_save/
(require 'nadvice)
(defun my-save-kill-ring (fun &rest _args)
  (let ((kill-ring nil))
    (funcall fun)))

(advice-add 'py-yapf-buffer :around 'my-save-kill-ring)
