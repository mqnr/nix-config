;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:
;; A clean, vanilla Emacs configuration.
;; Uses Elpaca for package management.

;;; Code:


;;; ── Elpaca bootstrap ────────────────────────────────────────────────────────

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package integration with Elpaca.
(elpaca elpaca-use-package
  ;; Enable :ensure support for Elpaca in use-package.
  (elpaca-use-package-mode)
  ;; Make :ensure t the default. We'll use :ensure nil explicitly
  ;; for built-in packages (emacs, which-key, flyspell, savehist, etc).
  (setq use-package-always-ensure t))

;; From this point, all use-package forms will use Elpaca by default.
;; Use `:ensure nil` for built-in packages.


;;; ── Housekeeping ────────────────────────────────────────────────────────────

;; Keep ~/.emacs.d clean by redirecting state and cache files.
;; Must be configured before other packages write their files.
(use-package no-littering
  :demand t
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))


;;; ── Core defaults ───────────────────────────────────────────────────────────

(use-package emacs
  :ensure nil
  :config
  ;; UTF-8 everywhere.
  (set-language-environment "UTF-8")

  ;; Always prefer newer files.
  (setq load-prefer-newer t)

  ;; Short answers (y/n instead of yes/no).
  (setq use-short-answers t)

  ;; Don't litter the filesystem with backup files.
  (setq make-backup-files nil)

  ;; Smoother scrolling.
  (setq scroll-conservatively 101
        scroll-margin 3)

  ;; Visuals.
  (setq-default truncate-lines t)
  (global-hl-line-mode 1)
  (column-number-mode 1)

  ;; Always show matching parens.
  (show-paren-mode 1)

  ;; Use spaces, not tabs.
  (setq-default indent-tabs-mode nil
                tab-width 4)

  ;; Single space after sentences.
  (setq sentence-end-double-space nil)

  ;; Keep the scratch buffer clean.
  (setq initial-scratch-message nil
        initial-major-mode 'fundamental-mode)

  ;; No startup screen.
  (setq inhibit-startup-screen t))


;;; ── macOS integration ───────────────────────────────────────────────────────

(use-package emacs
  :ensure nil
  :when (eq system-type 'darwin)
  :config
  ;; Use Command as Meta — the ergonomic choice on Mac.
  (setq mac-command-modifier 'meta
        mac-option-modifier  'none)

  ;; Don't pop up new frames when opening files.
  (setq ns-pop-up-frames nil)

  ;; Pixel-level scrolling with the trackpad.
  (setq mac-redisplay-dont-reset-vscroll t
        mac-mouse-wheel-smooth-scroll t)

  ;; Keep the menu bar (it's native on macOS and expected).
  (menu-bar-mode 1))

;; Inherit PATH and other env vars from the user's shell.
;; Essential on macOS where GUI apps don't get the shell environment.
(use-package exec-path-from-shell
  :demand t
  :when (eq system-type 'darwin)
  :config
  (exec-path-from-shell-initialize))


;;; ── Theme ───────────────────────────────────────────────────────────────────

;; Modus themes: accessible, polished. Built-in to Emacs 28+, but we install
;; the ELPA version because the built-in copy isn't on the load-path and
;; can't be loaded via normal `require'.
(use-package modus-themes
  :demand t
  :config
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t)
  (load-theme 'modus-vivendi :no-confirm))


;;; ── Minibuffer completion ───────────────────────────────────────────────────

;; Vertico: minimal, vertical completion UI.
(use-package vertico
  :config
  (vertico-mode 1))

;; Orderless: space-separated completion components, in any order.
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia: rich annotations in the minibuffer (docstrings, file info, etc.)
(use-package marginalia
  :config
  (marginalia-mode 1))

;; Consult: enhanced commands built on completing-read.
;; Replaces things like switch-to-buffer, grep, imenu with better versions.
(use-package consult
  :bind (("C-x b"   . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-g g"   . consult-goto-line)
         ("M-g i"   . consult-imenu)
         ("M-s r"   . consult-ripgrep)
         ("M-s l"   . consult-line)))


;;; ── In-buffer completion ────────────────────────────────────────────────────

;; Corfu: popup completion-at-point UI.
(use-package corfu
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-quit-no-match t)
  (global-corfu-mode 1))

;; Cape: additional completion-at-point backends.
;; cape-capf-buster is used in the lsp-mode setup below to keep completion
;; candidates consistent when the prefix changes mid-symbol.
(use-package cape
  :config
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file))


;;; ── Keybinding discoverability ──────────────────────────────────────────────

;; which-key is built into Emacs 30. No need to install.
(use-package which-key
  :ensure nil
  :config
  (which-key-mode 1))


;;; ── Version control ─────────────────────────────────────────────────────────

;; Explicitly installing transient here forces Elpaca to fetch the current ELPA
;; version.
(use-package transient)

(use-package magit
  :bind ("C-c g" . magit-status))


;;; ── LSP ─────────────────────────────────────────────────────────────────────

;; emacs-lsp-booster must be installed and on PATH.
;; It wraps LSP server processes to handle JSON parsing off the Emacs thread,
;; and requires lsp-use-plists=t (set via LSP_USE_PLISTS in early-init.el).
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or (when (equal (following-char) ?#)
        (let ((bytecode (read (current-buffer))))
          (when (byte-code-function-p bytecode)
            (funcall bytecode))))
      (apply old-fn args)))

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)
             (not (file-remote-p default-directory))
             lsp-use-plists
             (not (functionp 'json-rpc-connection))
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((prog-mode            . lsp-deferred)
         (lsp-mode             . lsp-enable-which-key-integration)
         (lsp-completion-mode  . mqnr/lsp-mode-setup-completion))
  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-use-plists t)
  ;; Wire up lsp-booster. The advice functions defined above are no-ops if
  ;; the emacs-lsp-booster binary is not found on PATH.
  (advice-add (if (progn (require 'json) (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around #'lsp-booster--advice-json-parse)
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
  ;; Completion: hand off to Corfu via capf rather than lsp-mode's own UI.
  (defun mqnr/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))
    ;; Wrap lsp-completion-at-point with cape-capf-buster for consistency
    ;; when the completion prefix changes mid-symbol.
    (setq-local completion-at-point-functions
                (list (cape-capf-buster #'lsp-completion-at-point)
                      #'cape-file
                      #'cape-dabbrev)))
  :config
  (setq lsp-completion-provider :none          ; Corfu handles completion
        lsp-idle-delay 0.5
        lsp-keep-workspace-alive nil            ; shut down server with last buffer
        lsp-headerline-breadcrumb-enable nil    ; handled by mode line / consult-imenu
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-signature-auto-activate t
        lsp-eldoc-enable-hover t))

;; lsp-ui: sideline diagnostics, hover docs, peek definitions.
(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-code-actions nil   ; too noisy inline; use C-c l a
        lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point))


;;; ── Tree-sitter ─────────────────────────────────────────────────────────────

;; treesit-auto: automatically install and use tree-sitter grammars.
(use-package treesit-auto
  :demand t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))


;;; ── Writing ─────────────────────────────────────────────────────────────────

;; Olivetti: distraction-free writing with centred, soft-wrapped text.
(use-package olivetti
  :hook (text-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 88))

;; Spell-checking. flyspell is built-in; just configure it.
(use-package flyspell
  :ensure nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))


;;; ── Persist minibuffer history ──────────────────────────────────────────────

(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))


;;; init.el ends here

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:
