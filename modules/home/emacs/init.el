;;; -*- lexical-binding: t; -*-

;; UI
(use-package emacs
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)
  (global-hl-line-mode 1)
  (setq inhibit-startup-screen t)
  (setq initial-scratch-message nil)
  (add-to-list 'default-frame-alist
               '(font . "Aporetic Sans Mono 16"))
  (add-to-list 'default-frame-alist
               '(alpha-background . 93))
  (load-theme 'ef-elea-dark t))

(use-package ef-themes
  :ensure t)

(use-package doom-themes
  :ensure t)

;; Editing
(use-package emacs
  :config
  (electric-pair-mode 1)
  (show-paren-mode 1)
  (global-auto-revert-mode 1)
  (delete-selection-mode 1)
  (setq-default indent-tabs-mode nil)
  (setq backup-directory-alist '((".*" . "~/.local/share/Trash"))))

;; Keybindings
(use-package emacs
  :bind
  ("C-=" . text-scale-increase)
  ("C-+" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("C-0" . text-scale-adjust)
  ([(control mouse-wheel-up)] . text-scale-increase)
  ([(control mouse-wheel-down)] . text-scale-decrease))

;; Other
(use-package emacs
  :custom
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
    '(read-only t cursor-intangible t face minibuffer-prompt)))

;; History
(use-package savehist
  :init
  (savehist-mode)
  :config
  (setq savehist-additional-variables
    '(kill-ring
      search-ring
      regexp-search-ring
      extended-command-history)))

;; Completion
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :config
  (when (< emacs-major-version 31)
    (advice-add #'completing-read-multiple :filter-args
                (lambda (args)
                  (cons (format "[CRM%s] %s"
                                (string-replace "[ \t]*" "" crm-separator)
                                (car args))
                        (cdr args))))))

(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package corfu
  :ensure t
  :init (global-corfu-mode)
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1))

(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; Useful commands
(use-package consult
  :ensure t
  :bind (;; C-c bindings in `mode-specific-map'
    ("C-c M-x" . consult-mode-command)
    ("C-c h" . consult-history)
    ("C-c k" . consult-kmacro)
    ("C-c m" . consult-man)
    ("C-c i" . consult-info)
    ([remap Info-search] . consult-info)
    ;; C-x bindings in `ctl-x-map'
    ("C-x M-:" . consult-complex-command)
    ("C-x b" . consult-buffer)
    ("C-x 4 b" . consult-buffer-other-window)
    ("C-x 5 b" . consult-buffer-other-frame)
    ("C-x t b" . consult-buffer-other-tab)
    ("C-x r b" . consult-bookmark)
    ("C-x p b" . consult-project-buffer)
    ;; Custom M-# bindings for fast register access
    ("M-#" . consult-register-load)
    ("M-'" . consult-register-store)
    ("C-M-#" . consult-register)
    ;; Other custom bindings
    ("M-y" . consult-yank-pop)
    ;; M-g bindings in `goto-map'
    ("M-g e" . consult-compile-error)
    ("M-g f" . consult-flymake)
    ("M-g g" . consult-goto-line)
    ("M-g M-g" . consult-goto-line)
    ("M-g o" . consult-outline)
    ("M-g m" . consult-mark)
    ("M-g k" . consult-global-mark)
    ("M-g i" . consult-imenu)
    ("M-g I" . consult-imenu-multi)
    ;; M-s bindings in `search-map'
    ("M-s d" . consult-find)
    ("M-s c" . consult-locate)
    ("M-s g" . consult-grep)
    ("M-s G" . consult-git-grep)
    ("M-s r" . consult-ripgrep)
    ("M-s l" . consult-line)
    ("M-s L" . consult-line-multi)
    ("M-s k" . consult-keep-lines)
    ("M-s u" . consult-focus-lines)
    ;; Isearch integration
    ("M-s e" . consult-isearch-history)
    :map isearch-mode-map
    ("M-e" . consult-isearch-history)
    ("M-s e" . consult-isearch-history)
    ("M-s l" . consult-line)
    ("M-s L" . consult-line-multi)
    ;; Minibuffer history
    :map minibuffer-local-map
    ("M-s" . consult-history)
    ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands. This
  ;; register formatting, adds thin separator lines, register
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"
)

;; Which-key
(use-package which-key
  :init (which-key-mode))

;; YASnippet
(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1))

;; Project management
(use-package project
  :bind (("C-x p p" . project-switch-project)
        ("C-x p f" . project-find-file)
        ("C-x p s" . project-shell)))

;; Nix
(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'"
  :hook (nix-ts-mode . eglot-ensure)
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(nix-ts-mode . ("nil")))))

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; The venerable Magit
(use-package magit
  :ensure t)
