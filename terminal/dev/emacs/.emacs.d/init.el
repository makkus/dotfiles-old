;; -*- emacs-lisp -*-
;;
;; Filename:      $HOME/.emacs.d/init.el
;; Time-stamp:    <2018-04-23 09:00:00 markus>
;; Source:        https://github.com/makkus/dotfiles/terminal/default/emacs/.emacs.d/init.el
;; Purpose:       configuration file for Emacs
;; Authors:       Markus Binsteiner
;; License:       GPL v2 or later
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; fast-starting method adapted from: https://github.com/nilcons/emacs-use-package-fast
;;
;;; Code:

(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
			       ;; restore after startup
			       (setq gc-cons-threshold 800000)))

(require 'package)
(setq package-enable-at-startup nil)   ; To prevent initialising twice
(setq package-user-dir "~/.cache/emacs/elpa")
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))


(setq my-user-emacs-directory "~/.emacs.d/")

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;;(add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

;; use-package for the case when init.el is byte-compiled
(use-package diminish
  :ensure t)
(use-package delight
  :ensure t)
(use-package bind-key
  :ensure t)

;; so we can (require 'use-package) even in compiled emacs to e.g. read docs
(use-package use-package :commands use-package-autoload-keymap)

(setq custom-file "~/.emacs.d/makkus-custom.el")
(load "~/.emacs.d/makkus-custom.el")

;;;; Global vars

(setq inhibit-startup-screen t
      initial-scratch-message ";; ready\n\n"
      auto-save-file-name-transforms (progn
				       (make-directory "~/.backups/emacs/auto-save-files/" t)
				       `((".*" "~/.backups/emacs/auto-save-files/" t)))
      select-enable-clipboard t
      select-enable-primary t)

;; too slow
;;(global-visual-line-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist '(("." . "~/.backups/emacs"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(setq org-src-tab-acts-natively t)
;;(setq frame-title-format '(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-na me)) "%b")))
(setq require-final-newline t)

;; auto uncompress compressed files
(auto-compression-mode t)

;; use desktop trash bin
(setq delete-by-moving-to-trash t)
(setq x-select-enable-clipboard-manager t)

(put 'suspend-frame 'disabled t)
(setq imenu-auto-rescan t)

(require 'paren)
(show-paren-mode 1)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match (face-foreground 'font-lock-comment-face))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; use C-p/C-n in comint mode, instead of M-p/M-n
(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-n") 'comint-next-input))

;;;; Functions

(defun find-config ()
  "Edit config.org"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

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
	(define-key map (kbd "b") #'makkus/pop-mark-repeat)
	(define-key map (kbd "q") #'keyboard-quit)
	map))
(defun makkus/pop-mark-repeat ()
  (interactive)
  (pop-to-mark-command)
  (set-transient-map
   pop-mark-repeat-keymap))

;;;; Appearance

;; fonts
(setq org-src-fontify-natively 't)
(set-frame-font "Hack 9" nil t)
(set-fontset-font t 'unicode "STIXGeneral" nil 'prepend)
(setq prettify-symbols-unprettify-at-point 'right-edge)
(global-prettify-symbols-mode 0)

;; theme

;; (use-package challenger-deep-theme
;;  :config
;;  (load-theme 'challenger-deep t))


;;;; Keybindings

;; which-key

(use-package which-key
  :ensure t
  :diminish
  :config
  (progn
    (which-key-setup-side-window-right-bottom)
    (setq which-key-sort-order 'which-key-key-order-alpha
	  which-key-side-window-max-width 0.33
	  which-key-idle-delay 0.05)
    (which-key-mode))
  )

;; chords

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1))

;; global

(bind-keys :map global-map
	   :prefix-map makkus-map
	   :prefix "M-SPC"
	   ("p" . projectile-switch-project)
	   ("b" . makkus/pop-mark-repeat)
	   ("B" . pop-global-mark))
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "M-i") 'counsel-imenu)
(global-set-key (kbd "C-q") 'delete-other-windows)
(global-set-key (kbd "C-M-c") 'makkus/comment-or-uncomment-region-or-line)
(bind-key "C-z" nil)
(bind-key* "C-o" 'other-window)

;; remap keybindings
(define-key global-map [remap kill-buffer] 'kill-buffer-and-window)

;; disable some keybindings
;; never suspend
(global-set-key "\C-x\C-z" nil)
(global-set-key (kbd "C-x C-z") nil)
(global-set-key "\C-z" nil)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)
(global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)

(global-set-key (kbd "C-M-r") 'repeat)

;;;; Packages

(use-package free-keys
  :ensure t
  :defer t)

(use-package xclip
  :ensure t
  :defer t
  :config
  (xclip-mode 1))
;; swiper
(use-package swiper
  :ensure t
  :defer t
  :bind (("C-s" . swiper)))

;; crux
(use-package crux
  :ensure t
  :defer t
  :chords (("\\d" . crux-duplicate-current-line-or-region))
  :bind (("C-a" . crux-move-beginning-of-line)
	 ("C-k" . crux-smart-kill-line)
	 ("C-M-\\" . crux-cleanup-buffer-or-region)
	 ("C-c r r" . crux-rename-file-and-buffer)))

(use-package smartparens
  :ensure t
  :defer t
  :diminish smartparens-mode
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode))

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 2)
    (setq company-show-numbers t)
    (use-package company-lsp
      :ensure t
      :config
      (add-to-list 'company-backends 'company-lsp))))

(use-package python-mode
  :defer t
  :ensure t
  :diminish
  :init
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  :config
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-interactive-args "-i"))

;;(use-package anaconda-mode
;;  :diminish
;;  :hook (python-mode anaconda-eldoc))
(use-package conda
  :defer t
  :ensure t
  :init
  (setq conda-anaconda-home "/home/markus/.local/share/inaugurate/conda/")
  :functions conda-env-initialize-interactive-shells
  :config
  (with-no-warnings
    (conda-env-initialize-interactive-shells)
    (conda-env-initialize-eshell))
  (setq-default mode-line-format (cons '(:exec conda-env-current-name) mode-line-format))
  )

(use-package projectile
  :ensure t
  :defer t
;;  :delight '(:eval (concat " proj(" (projectile-project-name) ")"))
  :init
  (setq projectile-completion-system 'ivy)
  :config
    (projectile-mode)
  )

(use-package winner
  :ensure t
  :defer nil
  :bind
  (("C-<" . winner-undo)
   ("C->" . winner-redo))
  :config
  (with-no-warnings
    (winner-mode))
  )

(use-package ivy
  :ensure t
  :defer t
  :diminish ivy-mode
  :config
  (progn
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  ))

(use-package counsel
  :ensure t
  :defer t
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ("C-c s a" . counsel-ag)
   ("C-c s l" . counsel-locate))
  :chords
  (("yy" . counsel-yank-pop))
  :config
   (use-package smex
    :ensure t)
  )


(use-package undo-tree
  :ensure t
  :defer t
  :chords (("uu" . undo-tree-visualize))
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode 1)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)
    ))


(use-package avy
  :ensure t
  :defer t
  :chords (("jk" . avy-goto-word-or-subword-1)
	   ("jl" . avy-goto-line)
	   ("JK" . makkus/avy-goto-end-of-word-or-subword-1)
	   ("JL" . makuks/avy-goto-end-of-line)))

(use-package ace-window
  :ensure t
  :defer t
  :chords (";j" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package expand-region
  :defer t
  :ensure t
  :chords ("vv" . er/expand-region)
  :config
  (setq expand-region-contract-fast-key "b"))

(use-package spaceline
  :ensure t
  :config
  (progn
    (require 'spaceline-config)
    (spaceline-spacemacs-theme)))

(use-package counsel-projectile
  :ensure t
  :hook after-init-hook
  )

(use-package flycheck
  :defer t
  :ensure t
  :diminish
  :config
  (progn
    (global-flycheck-mode)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package lsp-mode
  :ensure t
  :defer t
  )

(use-package lsp-python
  :defer t
  :ensure t
  :config
  (add-hook 'python-mode-hook #'lsp-python-enable))

;; (use-package lsp-imenu
;;   :config
;;   (add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

(use-package lsp-ui
  :ensure t
  :defer t
  :config
  (progn
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    (add-hook 'python-mode-hook 'flycheck-mode)))

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind (("C-c r l" . mc/edit-lines)))

(use-package iedit
  :ensure t
  :defer t
  :bind (("C-(" . 'iedit-mode)))

(use-package persp-mode
  :ensure t
  :defer nil
  :config
  (progn
    (with-eval-after-load "persp-mode-autoloads"
      (setq wg-morph-on nil) ;; switch off animation
      (setq persp-autokill-buffer-on-remove 'kill-weak)
      (add-hook 'after-init-hook #'(lambda () (persp-mode 1)))))
  )

(use-package persp-mode-projectile-bridge
  :ensure t
  :defer nil
  :config
  (progn
    (with-eval-after-load "persp-mode-projectile-bridge-autoloads"
       (add-hook 'persp-mode-projectile-bridge-mode-hook
		 #'(lambda ()
		     (if persp-mode-projectile-bridge-mode
			 (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
		       (persp-mode-projectile-bridge-kill-perspectives))))
       (add-hook 'after-init-hook
		 #'(lambda ()
		     (persp-mode-projectile-bridge-mode 1))
		 t))))

(use-package magit
  :ensure t
  :defer t
  :bind (("M-SPC g s" . magit-status)))

(provide 'init)
;;; init.el ends here
