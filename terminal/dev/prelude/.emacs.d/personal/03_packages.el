(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package crux
  :ensure t
  :defer t
  :chords (("\\d" . crux-duplicate-current-line-or-region))
  :bind (("C-a" . crux-move-beginning-of-line)
         ("C-M-\\" . crux-cleanup-buffer-or-region)
         ("C-c r r" . crux-rename-file-and-buffer)))

(use-package anaconda-mode
  :ensure t
  :bind (:map python-mode-map
              ("C-c ?" . anaconda-mode-show-doc)
              ("C-c b" . anaconda-mode-go-back))
  :config
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'eldoc-mode)))

(use-package py-yapf
  :ensure t
  :config
  (add-hook 'python-mode-hook 'py-yapf-enable-on-save))

(use-package conda
  :defer t
  :ensure t
  :init
  (setq conda-anaconda-home "/home/markus/.local/share/inaugurate/conda/")
  :functions conda-env-initialize-interactive-shells
  :config
  (with-no-warnings
    (conda-env-autoactivate-mode t)
    (conda-env-initialize-interactive-shells)
    (conda-env-initialize-eshell))
  (setq-default mode-line-format (cons '(:exec conda-env-current-name) mode-line-format)))

(use-package winner
  :ensure t
  :defer nil
  :bind
  (("C-<" . winner-undo)
   ("C->" . winner-redo))
  :config
  (winner-mode)
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

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind (("C-c r l" . mc/edit-lines)))

(use-package iedit
  :ensure t
  :defer t
  :bind (("C-(" . 'iedit-mode)))

(use-package magit
  :ensure t
  :defer t
  :bind (("M-SPC g s" . magit-status)))
