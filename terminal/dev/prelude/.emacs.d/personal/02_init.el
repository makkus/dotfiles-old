(prelude-require-package 'use-package)

(use-package delight
             :ensure t)
(use-package bind-key
  :ensure t)

;; global

;;; vars
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

(setq org-src-tab-acts-natively t
      org-src-fontify-natively t
      prettify-symbols-unprettify-at-point 'right-edge)

(setq backup-directory-alist '(("." . "~/.backups/emacs"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(put 'suspend-frame 'disabled t)


;; appearance

(set-frame-font "Hack 8" nil t)
(set-fontset-font t 'unicode "STIXGeneral" nil 'prepend)
(global-prettify-symbols-mode 0)


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
(bind-key* "M-i" 'counsel-imenu)
(bind-key* "M-I" 'imenu-anywhere)
(bind-key* "C-q" 'delete-other-menu)
(bind-key* "C-M-c" 'makkus/comment-or-uncomment-region-or-line)
(bind-key* "C-M-r" 'repeat)
(bind-key* "M-y" 'counsel-yank-pop)

(bind-keys :map global-map
           :prefix-map makkus-map
           :prefix "M-SPC"
           ("p" . projectile-switch-project)
           ("f" . projectile-find-file)
           ("F" . projectile-find-file-dwim-other-window)
           ("b" . projectile-switch-to-buffer)
           ("B" . projectile-switch-to-buffer-other-window)
           ("m" . makkus/pop-mark-repeat)
           ("M" . pop-global-mark)
           ("h f" . counsel-describe-function)
           ("h v" . counsel-describe-variable)
           ("h m" . counsel-describe-mode)
           ("h k" . describe-key)
           ("s a" . counsel-ag)
           ("s l" . counsel-locate)
           )

;;; chords

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1))

(key-chord-define-global "yy" 'counsel-yank-pop)

;;; hooks

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;; general mode configs

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-interactive-args "-i")

(which-key-setup-side-window-right-bottom)
(setq which-key-sort-order 'which-key-key-order-alpha)
