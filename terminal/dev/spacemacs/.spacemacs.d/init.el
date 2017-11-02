;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     php
     rust
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ivy
     better-defaults

     (colors :variables colors-enable-rainbow-identifiers t)

     (auto-completion :variables
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-return-key-behavior 'complete
                      auto-completion-complete-with-key-sequence-delay 0.01
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-sort-by-usage t
                      auto-completion-complete-with-key-sequence nil)

     (my-mu4e :variables mu4e-installation-path "~/.nix-profile/share/emacs/site-lisp/mu4e")

     spell-checking
     syntax-checking
     version-control
     gtags

     git
     github

     (python :variables python-enable-yapf-format-on-save nil python-sort-imports-on-save t)

     emacs-lisp
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     clojure
     lua
     common-lisp
     html
     shell-scripts

     markdown
     latex
     yaml
     ;;     plantuml
     semantic
     (org :variables org-enable-github-support t org-projectile-file "TODOs.org")

     ansible
     docker
     pandoc
     fasd
     imenu-list
     nginx
     pdf-tools

     deft

     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(key-chord password-generator xclip helm-projectile helm-gtags golden-ratio-scroll-screen zoom-window treemacs treemacs-projectile)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'random
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; Example for 5 recent files and 7 projects: '((recents . 5) (projects . 7))
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; (default nil)
   dotspacemacs-startup-lists '()
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("SourceCodePro"
   dotspacemacs-default-font '("Hack"
   ;;dotspacemacs-default-font '("FiraCode"
   ;;dotspacemacs-default-font '("Hasklig"
   ;; dotspacemacs-default-font '("Input"
                               :size 9
                               :weight normal
                               :width normal
                               :powerline-scale 1.4)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-SPC"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout t
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.3
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'origami
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

   ;; (setq configuration-layer--elpa-archives
         ;; '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
           ;; ("org-cn"   . "http://elpa.emacs-china.org/org/")
           ;; ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))
  (add-to-list 'load-path "~/.spacemacs.d/misc/")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;;;; temporary
  (setq-default persp-auto-save-opt 0)

  ;;;; external files
  (require 'markus_functions)
  (require 'config_helm)

  ;;;; key-chords
  (key-chord-define-global "jk" 'avy-goto-word-or-subword-1)
  (key-chord-define-global "JK" 'makkus/avy-goto-end-of-word-or-subword-1)
  ;;(key-chord-define-global ";j" 'hydra-navigation/body)
  (key-chord-define-global ";j" 'ace-window)

  (key-chord-define-global "vv" 'er/expand-region)

  (key-chord-define-global "zz" 'zoom-window-zoom)

  ;; (key-chord-define-global "jg" 'avy-goto-line)
  (key-chord-define-global "jl" 'avy-goto-line)
  (key-chord-define-global "JL" 'makkus/avy-goto-end-of-line)
  (key-chord-define-global ";j" 'hydra-navigation/body)
  ;; (key-chord-define-global "jf" 'hydra-goto-commands/body)
  ;; (key-chord-define-global "jj" 'avy-goto-char-2)
  ;; (key-chord-define-global "jp" 'hydra-smartparens/body)
  ;; (key-chord-define-global ";d" 'hydra-display-commands/body)
  ;; (key-chord-define-global ";i" 'my-save-word)
  (key-chord-mode t)

  (require 'golden-ratio-scroll-screen)
  (global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
  (global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)

  ;; dumbjump
  (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)

  ;;;; keybindings
  (global-set-key (kbd "C-o") 'other-window)
  (global-set-key (kbd "M-P") 'avy-pop-mark)
  (global-set-key (kbd "C-S-s") 'swiper-all)

  (global-set-key (kbd "C-\\") 'my-helm)
  (global-set-key (kbd "C-|") 'counsel-projectile-switch-project)
  (global-set-key (kbd "M-i") 'helm-semantic-or-imenu)

  (global-set-key (kbd "C-<") 'winner-undo)
  (global-set-key (kbd "C->") 'winner-redo)

  (global-set-key (kbd "C-q") 'delete-other-windows)
  (global-set-key (kbd "<f11>") 'makkus/full-screen-toggle)

  (global-set-key (kbd "C-M-c") 'makkus/comment-or-uncomment-region-or-line)

  (global-set-key (kbd "C-(") 'iedit-mode)
  (global-set-key (kbd "C-;") 'avy-goto-word-or-subword-1)
  (global-set-key (kbd "M-g M-g") 'avy-goto-line)
  (global-set-key (kbd "M-g g") 'avy-goto-line)
  (global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)

  (global-set-key (kbd "M-g o") 'dumb-jump-go-other-window)
  (global-set-key (kbd "M-g j") 'dumb-jump-go)
  (global-set-key (kbd "M-g b") 'dumb-jump-back)
  (global-set-key (kbd "M-g i") 'dumb-jump-go-prompt)
  (global-set-key (kbd "M-g x") 'dumb-jump-go-prefer-external)
  (global-set-key (kbd "M-g z") 'dumb-jump-go-prefer-external-other-window)

  (global-set-key (kbd "M-C-s") 'anzu-query-replace)

  ;; remap keybindings
  (define-key global-map [remap kill-buffer] 'kill-buffer-and-window)

  ;; disable some keybindings
  ;; never suspend
  (global-set-key "\C-x\C-z" nil)
  (global-set-key (kbd "C-x C-z") nil)
  (global-set-key "\C-z" nil)
  (global-set-key (kbd "C-z") nil)
  (put 'suspend-frame 'disabled t)


  ;; custom
  ;;  (global-set-key (kbd "C-:") 'makkus/avy-goto-end-of-word-or-subword-1)

  ;;;; avy/ivy/swiper stuff
  (defcustom avy-dispatch-alist
    '((?x . avy-action-kill-move)
      (?y . avy-action-kill-stay)
      (?v . avy-action-mark)
      (?w . avy-action-copy)
      (?i . avy-action-ispell))
    "List of actions for `avy-handler-default'.
 Each item is (KEY . ACTION).  When KEY not on `avy-keys' is
 pressed during the dispatch, ACTION is set to replace the default
 `avy-action-goto' once a candidate is finally selected."
    :type
    '(alist
      :key-type (choice (character :tag "Char"))
      :value-type (choice
                   (const :tag "Mark" avy-action-mark)
                   (const :tag "Copy" avy-action-copy)
                   (const :tag "Kill and move point" avy-action-kill-move)
                   (const :tag "Kill" avy-action-kill-stay))))
  (setq ivy-virtual-abbreviate 'full)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
        ;; allow input not in order
        '((t   . ivy--regex-ignore-order)))


  ;; show full path for helm-source-recentf
  (setq helm-ff-transformer-show-only-basename nil)

  ;;;; backup
  ;; store backups in a common folder, do version control, don't delete anything
  (setq backup-directory-alist '(("." . "~/.backups/emacs")))
  (setq delete-old-versions -1)
  (setq version-control t)
  (setq vc-make-backup-files t)
  (setq auto-save-file-name-transforms '((".*" "~/.backups/emacs" t)))

  (setq create-lockfiles nil)


  ;;;; deft
  ;; set deft notes directory
  (setq deft-directory "~/Documents/notes")
  (setq deft-extensions '("org"))
  (setq deft-use-filename-as-title t)

  ;;;; misc
  ;; display current directory in modline
  (setq frame-title-format '(:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-na me)) "%b")))
  (setq require-final-newline t)

  ;; auto uncompress compressed files
  (auto-compression-mode t)

  ;; use desktop trash bin
  (setq delete-by-moving-to-trash t)

  ;; use x clipboard
  (setq x-select-enable-clipboard t)
  (setq x-select-enable-primary t)
  (global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)
  (setq x-select-enable-clipboard-manager t)
  (require 'xclip)
  (xclip-mode 1)

  (global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)

  ;; tab-width
  (setq-default tab-width 2)

  ;; imenu
  (setq imenu-auto-rescan t)

  ;; company
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0)
  (setq company-show-numbers t)


  ;; python
  (setenv "WORKON_HOME" "/home/markus/.freckles/opt/conda/envs")
  (pyenv-mode 1)
  ;; temporary fix for anaconda-buffer popping up all the time ( https://github.com/proofit404/anaconda-mode/issues/183 )
  (setq company-idle-delay 0.5)
  (require 'anaconda-mode)
  (remove-hook 'anaconda-mode-response-read-fail-hook
               'anaconda-mode-show-unreadable-response)

   ;;;; eval after loads
  (eval-after-load 'smartparens
    '(progn
       (sp-local-pair 'inferior-python-mode "(" nil :unless nil)
       (sp-local-pair 'inferior-python-mode "{" nil :unless nil)
       (sp-local-pair 'inferior-python-mode "[" nil :unless nil)
       (sp-local-pair 'inferior-python-mode "'" nil :unless nil)
       (sp-local-pair 'inferior-python-mode "\"" nil :unless nil)
       (sp-local-pair 'inferior-python-mode "\"" nil :unless nil)))

  ;; use C-p/C-n in comint mode, instead of M-p/M-n
  (with-eval-after-load 'comint
    (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
    (define-key comint-mode-map (kbd "C-n") 'comint-next-input))

  (with-eval-after-load 'org
    (require 'config_org))

  (with-eval-after-load 'avy
    (advice-add 'swiper :before 'avy-push-mark) )

  ;;;; hooks
  (advice-add 'isearch-search :after (lambda (&rest args) "Recenter" (when isearch-success (makkus/recenter-no-redraw))))
  (advice-add 'swiper :after (lambda (&rest args) "Recenter"  (makkus/recenter-no-redraw)))
  (advice-add 'helm-semantic-or-imenu :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))
  (advice-add 'avy-goto-line :after (lambda (&rest args) "Recenter" (makkus/recenter-no-redraw)))

  (add-hook 'sh-mode-hook 'flycheck-mode)

  ;;;; hydras
  (defhydra multiple-cursors-hydra (:hint nil)
    "
     ^Up^            ^Down^        ^Other^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("r" mc/mark-all-in-region-regexp :exit t)
  ("q" nil))

  (global-set-key (kbd "M-SPC s m") 'multiple-cursors-hydra/body)

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(evil-want-Y-yank-to-eol t)
 '(package-selected-packages
   (quote
    (treemacs-projectile treemacs phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode toml-mode racer flycheck-rust cargo rust-mode org-category-capture zoom-window mu4e-maildirs-extension mu4e-alert winum unfill slime-company insert-shebang hide-comnt golden-ratio-scroll-screen fuzzy company-ansible deft xclip password-generator key-chord origami smtpmail-multi powerline parent-mode helm helm-core flx smartparens iedit anzu evil goto-chg undo-tree diminish projectile hydra highlight seq spinner pkg-info epl bind-map bind-key packed async f dash s avy popup package-build yaml-mode xterm-color web-mode tagedit stickyfunc-enhance srefactor smeargle slime slim-mode shell-pop scss-mode sass-mode rainbow-mode rainbow-identifiers pug-mode pdf-tools pandoc-mode ox-pandoc ox-gfm orgit org-projectile org-present org org-pomodoro alert log4e gntp org-download nginx-mode mwim multi-term mmm-mode markdown-toc markdown-mode magit-gitflow magit-gh-pulls lua-mode less-css-mode jinja2-mode imenu-list htmlize helm-gtags haml-mode gnuplot gitignore-mode github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gist gh marshal logito pcache ht gh-md ggtags flyspell-correct-ivy flyspell-correct flycheck-pos-tip pos-tip flycheck fish-mode fasd grizzl evil-magit magit git-commit with-editor eshell-z eshell-prompt-extras esh-help emmet-mode dockerfile-mode docker json-mode tablist magit-popup docker-tramp json-snatcher json-reformat diff-hl company-web web-completion-data company-statistics company-shell company-auctex company-anaconda company common-lisp-snippets color-identifiers-mode clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg cider-eval-sexp-fu cider queue clojure-mode auto-yasnippet yasnippet auto-dictionary auctex ansible-doc ansible ac-ispell auto-complete debbugs yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode cython-mode anaconda-mode pythonic wgrep smex ivy-hydra counsel-projectile counsel swiper ivy ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spacemacs-theme spaceline restart-emacs request rainbow-delimiters quelpa popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
