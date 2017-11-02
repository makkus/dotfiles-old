;;; packages.el --- my-mu4e layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Markus Binsteiner <markus@bud>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `my-mu4e-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-mu4e/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-mu4e/pre-init-PACKAGE' and/or
;;   `my-mu4e/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq mu4e-mu-binary "~/.nix-profile/bin/mu")
(setq mu4e-msg2pdf "/usr/bin/msg2pdf")
(setq my-mu4e-packages
      '((mu4e :location built-in) smtpmail-multi))



;;;; smtpmail-multi
(defun my-mu4e/init-smtpmail-multi ()
  (use-package smtpmail-multi
    :ensure smtpmail-multi
    :init
    (progn

      (setq message-send-mail-function 'smtpmail-multi-send-it)
      (setq smtpmail-debug-verb t)
      (setq smtpmail-debug-info t)))
  )

(defun my-mu4e/init-mu4e ()

  (use-package mu4e
    :commands (mu4e mu4e-compose-new)
    :init
    (progn
      (spacemacs/set-leader-keys "a M" 'mu4e)
      (global-set-key (kbd "C-x m") 'mu4e-compose-new))
    :config
    (progn
      ;; get accounts info and such
      (require 'config_mu4e)
      ;; header date format
      (setq  mu4e-headers-date-format "%Y-%m-%d %H:%M")

      ;; show full addresses in view message (instead of just names)
      ;; toggle per name with M-RET
      (setq mu4e-view-show-addresses 't)

      (setq mu4e-context-policy 'pick-first)

      ;; show full addresses in view message (instead of just names)
      ;; toggle per name with M-RET
      (setq mu4e-view-show-addresses 't)


      (setq mu4e-headers-fields
            '( (:date          .  25)
               (:flags         .   6)
               (:from          .  22)
               (:subject       .  nil)))

      (setq mu4e-get-mail-command "true")
      (setq mu4e-update-interval 20)

      (setq message-kill-buffer-on-exit t)
      (setq mu4e-attachment-dir  "~/Downloads")
      (setq mu4e-change-filenames-when-moving 't)

      (setq mu4e-compose-in-new-frame 't)

      (setq mu4e-split-view 'horizontal)
      (setq mu4e-headers-visible-lines 16)

      (setq mu4e-view-show-images t)
      (setq org-mu4e-link-query-in-headers-mode t)
      (require 'mu4e-contrib)

      (setq mu4e-html2text-command 'mu4e-shr2text)
      )
    )
  )

;;; packages.el ends here
