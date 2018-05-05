(prelude-require-package 'use-package)

(use-package delight
             :ensure t)
(use-package bind-key
  :ensure t)

;; global

;;; vars

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq browse-url-browser-function 'eww-browse-url)

(setq inhibit-startup-screen t
      initial-scratch-message ";; ready\n\n"
      auto-save-file-name-transforms (progn
                                       (make-directory "~/.backups/emacs/auto-save-files/" t)
                                       `((".*" "~/.backups/emacs/auto-save-files/" t)))
      select-enable-clipboard t
      select-enable-primary t
      help-window-select t
      scroll-bar-mode -1
      tool-bar-mode -1
      require-final-newline t
      delete-by-moving-to-trash t
      x-select-enable-clipboard-manager t
      imenu-auto-rescan t)

(setq prettify-symbols-unprettify-at-point 'right-edge)

(setq backup-directory-alist '(("." . "~/.backups/emacs"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(setq ivy-initial-inputs-alist nil)

(setq prelude-auto-save nil)
(setq split-height-threshold nil)
(setq split-width-threshold 80)

(setq tab-always-indent 'complete)

(put 'suspend-frame 'disabled t)

;; appearance

(set-frame-font "Hack 8" nil t)
(set-fontset-font t 'unicode "STIXGeneral" nil 'prepend)
(global-prettify-symbols-mode 0)

(setq whitespace-style '(face tabs empty trailing))

;;;; setting font for emacs client
(setq default-frame-alist '((font . "Hack 8")))


;;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)


;;; keybindings

(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-n") 'comint-next-input))

(define-key global-map [remap kill-buffer] 'kill-buffer-and-window)

(bind-key* "C-z" nil)
(bind-key* "C-x C-z" nil)
(bind-key* "C-o" 'other-window)
(bind-key* "<mouse-2>" 'x-clipboard-yank)
(bind-key* "M-i" 'counsel-semantic-or-imenu)
(bind-key* "M-I" 'imenu-anywhere)
(bind-key* "C-q" 'ace-delete-other-windows)
(bind-key* "C-M-c" 'makkus/comment-or-uncomment-region-or-line)
(bind-key* "C-M-r" 'repeat)
(bind-key* "C-c \\" 'makkus/toggle-window-split)
(bind-key* "M-y" 'kill-ring-save)
(bind-key* "M-y" 'counsel-yank-pop)


(bind-keys :map global-map
           :prefix-map makkus-map
           :prefix "M-SPC"
           ("p" . persp-switch)
           ("P" . projectile-persp-switch-project)
           ("f" . projectile-find-file)
           ("F" . projectile-find-file-dwim-other-window)
           ("b" . projectile-switch-to-buffer)
           ("B" . projectile-switch-to-buffer-other-window)
           ("m" . makkus/pop-mark-repeat)
           ("M" . pop-global-mark)
           ("e l" . mc/edit-lines)
           ("h f" . counsel-describe-function)
           ("h v" . counsel-describe-variable)
           ("h m" . counsel-describe-mode)
           ("h k" . describe-key)
           ("s a" . counsel-ag)
           ("s l" . counsel-locate)
           ("w t" . makkus/toggle-window-split)
           ("w s" . ace-window)
           ("w S" . ace-swap-window)
           ("w q" . ace-delete-other-windows)
           )

;;; chords

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1))

(key-chord-define-global "yy" 'counsel-yank-pop)

;;; hooks

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; advices

(advice-add 'isearch-search :after (lambda (&rest args) "Recenter" (when isearch-success (makkus/recenter-no-redraw))))
(advice-add 'swiper :after (lambda (&rest args) "Recenter"  (makkus/recenter-no-redraw)))
(advice-add 'helm-semantic-or-imenu :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'counsel-semantic-or-imenu :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'makkus/pop-mark-repeat :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'avy-goto-line :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'counsel-ag :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'counsel-rg :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'counsel-projectile-ag :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
(advice-add 'counsel-projectile-rg :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))


;;; general mode configs

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-interactive-args "-i")

(which-key-setup-side-window-right-bottom)
(setq which-key-sort-order 'which-key-key-order-alpha)
